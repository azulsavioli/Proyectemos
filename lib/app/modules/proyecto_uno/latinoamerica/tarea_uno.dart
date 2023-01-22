import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/services/storage_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/strings_latinoamerica.dart';
import '../../../../commons/styles.dart';
import '../../../proyectemos_repository.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/drawer_menu.dart';

class PUnoLatinoamericaTareaUnoPage extends StatefulWidget {
  const PUnoLatinoamericaTareaUnoPage({Key? key}) : super(key: key);

  @override
  State<PUnoLatinoamericaTareaUnoPage> createState() =>
      _PUnoLatinoamericaTareaUnoPageState();
}

class _PUnoLatinoamericaTareaUnoPageState
    extends State<PUnoLatinoamericaTareaUnoPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageService storageService = StorageService();

  final formKey = GlobalKey<FormState>();
  final _answerUnoController = TextEditingController();
  final _answerDosController = TextEditingController();

  late YoutubePlayerController controller;
  late TextEditingController idController;
  late TextEditingController seekToController;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  final double volume = 100;
  final bool muted = false;
  final bool isPlayerReady = false;

  bool loading = false;

  @override
  initState() {
    super.initState();

    controller = YoutubePlayerController(
      initialVideoId: "R21d66HYGPw",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    idController = TextEditingController();
    seekToController = TextEditingController();
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.buffering;
  }

  void listener() {
    if (isPlayerReady && mounted && !controller.value.isFullScreen) {
      setState(() {
        playerState = controller.value.playerState;
        videoMetaData = controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    idController.dispose();
    seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        automaticallyImplyLeading: true,
        title: const Text(Strings.titleLatinoamericaUno,
            style: ThemeText.paragraph16WhiteBold),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringsLationamerica.titleQOnePageOneLatin,
                      style: ThemeText.paragraph16GrayNormal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      StringsLationamerica.qOneLatinPageOne,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerUnoController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorque10:
                          'Su respuesta debe tener al menos 10 caracteres',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      StringsLationamerica.qTwoLatinPageOne,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerDosController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorque10:
                          'Su respuesta debe tener al menos 10 caracteres',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      StringsLationamerica.titleQtwoPageOneLatin,
                      style: ThemeText.paragraph16GrayNormal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    YoutubePlayer(
                      thumbnail: const Text(
                          "https://img.youtube.com/vi/R21d66HYGPw/hqdefault.jpg"),
                      controller: controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: ThemeColors.yellow,
                      progressColors: const ProgressBarColors(
                        playedColor: ThemeColors.yellow,
                        handleColor: ThemeColors.yellow,
                      ),
                      onReady: () {
                        controller.addListener(listener);
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          final json = {
                            'resposta_1': _answerUnoController.text,
                            'resposta_2': _answerDosController.text,
                          };

                          deactivate();
                          sendAnswersToFirebase(json);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Resposta enviada com sucesso!"),
                            duration: Duration(seconds: 2),
                          ));
                          Navigator.pushNamed(
                              context, '/pUno_latinoamerica_tarea_dos');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (loading)
                              ? [
                                  const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ]
                              : [
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Contínua",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios),
                                ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendAnswersToFirebase(json) async {
    String doc = 'uno/latinoamerica/atividade_1/';
    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, json);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
