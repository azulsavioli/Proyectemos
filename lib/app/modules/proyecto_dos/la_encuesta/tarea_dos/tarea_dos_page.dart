import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_la_encuesta.dart';
import 'package:proyectemos/services/toast_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../commons/styles.dart';
import '../../../../../providers/record_audio_provider_la_encuesta_tarea_dos.dart';
import '../../../../../services/storage_service.dart';
import '../../../../../utils/get_user.dart';
import 'intro_tarea_dos_como_crear_una_encuesta.dart';

import 'question_dos_como_crear_una_encuesta.dart';
import 'question_one_como_crear_una_encuesta.dart';
import 'question_tres_como_crear_una_encuesta.dart';
import 'tarea_dos_controller.dart';

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
  final _controller = TareaDosComoCrearUnaEncuestaController();

  List<String> recordsPathList =
      RecordAudioLaEncuestaTareaDosProviderImpl.recordingsPaths;

  final _formKey = GlobalKey<FormState>();
  final pageController = PageController();

  int pageChanged = 0;

  late YoutubePlayerController youTubeController;
  late TextEditingController idController;
  late TextEditingController seekToController;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  final double volume = 100;
  final bool muted = false;
  final bool isPlayerReady = false;
  final bool isAccessible = false;

  bool loading = false;

  final focusNode1 = FocusNode();
  final textEditingController1 = TextEditingController();
  final focusNode2 = FocusNode();
  final textEditingController2 = TextEditingController();
  final focusNode3 = FocusNode();
  final textEditingController3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getIsAcessible();
    setState(() {
      isAccessible == _controller.isAccessible;
    });

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

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
                controller: _controller,
                focusNode: focusNode1,
                textController: textEditingController1,
              ),
              QuestionComoCrearUnaEncuestaDos(
                controller: _controller,
                focusNode: focusNode2,
                textController: textEditingController2,
              ),
              QuestionComoCrearUnaEncuestaTres(
                controller: _controller,
                focusNode: focusNode3,
                textController: textEditingController3,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: loading
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
                      count: 4,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.blueAccent,
                        dotColor: Colors.black26,
                      ),
                    ),
                  ),
                  if (pageChanged == 3)
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () async {
                        setState(() {
                          if (pageChanged == 1) {
                            youTubeController.addListener(listener);
                          } else {
                            youTubeController.removeListener(listener);
                          }
                        });
                        deactivate();
                        if (_controller.isAccessible!) {
                          if (!_formKey.currentState!.validate() ||
                              textEditingController1.text.isEmpty ||
                              textEditingController2.text.isEmpty ||
                              textEditingController3.text.isEmpty) {
                            showToast(
                              '''
¡No se puede enviar la respuesta! Selecione las opciones, escribe las respostas y haz clic en enviar!''',
                              color: ThemeColors.red,
                              textColor: ThemeColors.white,
                            );
                          } else {
                            if (textEditingController1.text.isNotEmpty &&
                                textEditingController2.text.isNotEmpty &&
                                textEditingController3.text.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                              Future.delayed(Duration(milliseconds: 2000)).then(
                                (value) {
                                  if (mounted) {
                                    final respostas =
                                        _controller.makeAnswerList(
                                      textEditingController1.text,
                                      textEditingController2.text,
                                      textEditingController3.text,
                                    );

                                    _controller.sendAnswersText(
                                        currentUser, respostas);
                                    Navigator.pushNamed(
                                      context,
                                      '/pDos_laEncuesta_menu',
                                    );
                                  }
                                },
                              );
                            }
                          }
                        } else {
                          if (recordsPathList.isEmpty ||
                              recordsPathList.length < 3) {
                            showToast(
                              '''
¡No se puede enviar la respuesta! Selecione las opciones, graba los audios y haz clic en guardar!''',
                              color: ThemeColors.red,
                              textColor: ThemeColors.white,
                            );
                          } else {
                            if (recordsPathList.isNotEmpty &&
                                recordsPathList.length == 3) {
                              setState(() {
                                loading = true;
                              });
                              Future.delayed(Duration(milliseconds: 2000)).then(
                                (value) {
                                  if (mounted) {
                                    _controller.sendAnswersAudio(
                                      currentUser,
                                      recordsPathList,
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      '/pDos_laEncuesta_menu',
                                    );
                                  }
                                },
                              );
                            }
                          }
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
