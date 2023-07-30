import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_uno/latinoamerica/tarea_uno/tarea_uno_revision.dart';
import 'package:proyectemos/services/toast_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../commons/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/storage_service.dart';
import '../../../../../utils/get_user.dart';
import 'intro_tareas_latinoamerica.dart';
import 'question_five.dart';
import 'question_four.dart';
import 'question_one.dart';
import 'question_three.dart';
import 'question_two.dart';
import 'tarea_uno_controller.dart';

class TareaUnoLatinoamericaPage extends StatefulWidget {
  const TareaUnoLatinoamericaPage({Key? key}) : super(key: key);

  @override
  State<TareaUnoLatinoamericaPage> createState() =>
      _TareaUnoLatinoamericaPageState();
}

class _TareaUnoLatinoamericaPageState extends State<TareaUnoLatinoamericaPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageService storageService = StorageService();
  final _tareaUnoController = TareaUnoController();

  final _formKey = GlobalKey<FormState>();
  final pageController = PageController();

  final textControllerOne = TextEditingController();
  final textControllerTwo = TextEditingController();
  final textControllerThree = TextEditingController();
  final textControllerFour = TextEditingController();
  final textControllerFive = TextEditingController();
  int pageChanged = 0;

  late YoutubePlayerController youTubeController;
  late TextEditingController idController;
  late TextEditingController seekToController;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  final double volume = 100;
  final bool muted = false;
  final bool isPlayerReady = false;

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();

    youTubeController = YoutubePlayerController(
      initialVideoId: 'R21d66HYGPw',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
      ),
    )..addListener(listener);
    idController = TextEditingController();
    seekToController = TextEditingController();
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.buffering;
  }

  void listener() {
    if (isPlayerReady && mounted && !youTubeController.value.isFullScreen) {
      setState(() {
        playerState = youTubeController.value.playerState;
        videoMetaData = youTubeController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    pageController.dispose();
    youTubeController.dispose();
    idController.dispose();
    seekToController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);
    final textOne = textControllerOne.text;
    final textTwo = textControllerTwo.text;
    final textThree = textControllerThree.text;
    final textFour = textControllerFour.text;
    final textFive = textControllerFive.text;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          },
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: Text(
          Strings.titleLatinoamericaUno,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: PageView(
            onPageChanged: (index) {
              if (index == 0) {
                focusNode1.requestFocus();
              }
              if (index == 1) {
                FocusScope.of(context).unfocus();
              }
              if (index == 2) {
                focusNode2.requestFocus();
              }
              if (index == 3) {
                focusNode3.requestFocus();
              }
              if (index == 4) {
                focusNode4.requestFocus();
              }
              if (index == 5) {
                focusNode5.requestFocus();
              }
              if (index == 6) {
                FocusScope.of(context).unfocus();
              }
              setState(() {
                pageChanged = index;
              });
            },
            controller: pageController,
            children: [
              IntroTareaLatinoamericaPage(
                focusNode: focusNode1,
                controller: textControllerOne,
              ),
              QuestionLatinoamericaOne(
                controller: youTubeController,
                listener: listener,
              ),
              QuestionLatinoamericaTwo(
                focusNode: focusNode2,
                controller: textControllerTwo,
              ),
              QuestionLatinoamericaThree(
                focusNode: focusNode3,
                controller: textControllerThree,
              ),
              QuestionLatinoamericaFour(
                focusNode: focusNode4,
                controller: textControllerFour,
              ),
              QuestionLatinoamericaFive(
                focusNode: focusNode5,
                controller: textControllerFive,
              ),
              RevisionQuestionsLatinoamerica(
                controllerList: [
                  textControllerOne,
                  textControllerTwo,
                  textControllerThree,
                  textControllerFour,
                  textControllerFive,
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (pageChanged == 0)
              const SizedBox(
                width: 65,
              )
            else
              TextButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 7,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.blueAccent,
                  dotColor: Colors.black26,
                ),
              ),
            ),
            if (pageChanged == 6)
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ThemeColors.blue),
                ),
                onPressed: () {
                  setState(() {
                    if (pageChanged == 1) {
                      youTubeController.addListener(listener);
                    } else {
                      youTubeController.removeListener(listener);
                    }
                  });
                  deactivate();
                  if (textControllerOne.text.isEmpty ||
                      textControllerTwo.text.isEmpty ||
                      textControllerThree.text.isEmpty ||
                      textControllerFour.text.isEmpty ||
                      textControllerFive.text.isEmpty) {
                    showToast(
                      color: ThemeColors.red,
                      'Vuelve y ingrese tuja respuesta correctamente',
                    );
                  } else {
                    final respostas = _tareaUnoController.makeAnswersList(
                      textOne,
                      textTwo,
                      textThree,
                      textFour,
                      textFive,
                    );

                    _tareaUnoController.sendAnswers(
                      currentUser,
                      respostas,
                    );

                    Navigator.pushNamed(
                      context,
                      '/pUno_latinoamerica_menu',
                    );
                  }
                },
                child: const Text(
                  'Concluir',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              TextButton(
                onPressed: () {
                  setState(() {
                    if (pageChanged == 1) {
                      youTubeController.addListener(listener);
                    } else {
                      youTubeController.removeListener(listener);
                    }
                  });
                  if (pageChanged == 6) {
                    deactivate();
                  }

                  pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  'Próximo',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
