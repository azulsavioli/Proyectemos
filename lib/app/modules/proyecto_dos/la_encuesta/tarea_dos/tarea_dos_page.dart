import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_la_encuesta.dart';
import 'package:proyectemos/services/toast_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../commons/styles.dart';
import '../../../../../services/storage_service.dart';
import '../../../../../utils/get_user.dart';
import 'intro_tarea_dos_como_crear_una_encuesta.dart';

import 'question_dos_como_crear_una_encuesta.dart';
import 'question_one_como_crear_una_encuesta.dart';
import 'question_tres_como_crear_una_encuesta.dart';
import 'tarea_dos_controller.dart';
import 'tarea_uno_revision.dart';

class TareaDosComoCrearUnaEncuestaPage extends StatefulWidget {
  const TareaDosComoCrearUnaEncuestaPage({Key? key}) : super(key: key);

  @override
  State<TareaDosComoCrearUnaEncuestaPage> createState() =>
      _TareaDosComoCrearUnaEncuestaPageState();
}

class _TareaDosComoCrearUnaEncuestaPageState
    extends State<TareaDosComoCrearUnaEncuestaPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageService storageService = StorageService();
  final _tareaUnoController = TareaDosComoCrearUnaEncuestaController();

  final _formKey = GlobalKey<FormState>();
  final pageController = PageController();

  final textControllerOne = TextEditingController();
  final textControllerTwo = TextEditingController();
  final textControllerThree = TextEditingController();

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

  bool loading = false;

  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();

    youTubeController = YoutubePlayerController(
      initialVideoId: 'HVk3UYTKCr0',
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);
    final textOne = textControllerOne.text;
    final textTwo = textControllerTwo.text;
    final textThree = textControllerThree.text;

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
          StringsLaEncuesta.titleTareaDosComoCrearUnaEncuesta,
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
                FocusScope.of(context).unfocus();
              }
              if (index == 1) {
                focusNode2.requestFocus();
              }
              if (index == 2) {
                focusNode1.requestFocus();
              }
              if (index == 3) {
                focusNode3.requestFocus();
              }

              setState(() {
                pageChanged = index;
              });
            },
            controller: pageController,
            children: [
              IntroTareaComoCrearUnaEncuestaPageimport(
                controller: youTubeController,
                listener: listener,
              ),
              QuestionComoCrearUnaEncuestaOne(
                focusNode: focusNode1,
                controller: textControllerOne,
              ),
              QuestionComoCrearUnaEncuestaDos(
                focusNode: focusNode2,
                controller: textControllerTwo,
              ),
              QuestionComoCrearUnaEncuestaTres(
                focusNode: focusNode3,
                controller: textControllerThree,
              ),
              RevisionQuestionsComoCrearUnaEncuesta(
                controllerList: [
                  textControllerOne,
                  textControllerTwo,
                  textControllerThree,
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: loading
          ? const LinearProgressIndicator(
              minHeight: 20,
              color: ThemeColors.blue,
            )
          : Container(
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
                        'Volver',
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
                      count: 5,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.blueAccent,
                        dotColor: Colors.black26,
                      ),
                    ),
                  ),
                  if (pageChanged == 4)
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
                            textControllerThree.text.isEmpty) {
                          showToast(
                            color: ThemeColors.red,
                            'Vuelve y ingrese tuja respuesta correctamente',
                          );
                        } else {
                          final respostas = _tareaUnoController.makeAnswersList(
                            textOne,
                            textTwo,
                            textThree,
                          );
                          setState(() {
                            loading = true;
                          });
                          _tareaUnoController
                              .sendAnswers(
                                currentUser,
                                respostas,
                              )
                              .then(
                                (value) => Navigator.pushNamed(
                                  context,
                                  '/pDos_laEncuesta_menu',
                                ),
                              );
                        }
                      },
                      child: const Text(
                        'Enviar',
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
