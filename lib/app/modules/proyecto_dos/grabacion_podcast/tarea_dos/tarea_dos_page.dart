import 'package:flutter/material.dart';
import 'package:proyectemos/services/toast_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../commons/strings/strings_grabacion_podcast.dart';
import '../../../../../commons/styles.dart';
import '../../../../../utils/get_user.dart';
import 'intro_dos_tarea_grabacion_podcast.dart';
import 'intro_one_tarea_grabacion_podcast.dart';
import 'intro_tres_tarea_grabacion_podcast.dart';
import 'question_one_grabacion_podcast.dart';
import 'tarea_dos_controller.dart';

class TareaDosGrabacionPodcastPage extends StatefulWidget {
  const TareaDosGrabacionPodcastPage({Key? key}) : super(key: key);

  @override
  State<TareaDosGrabacionPodcastPage> createState() =>
      _TareaDosGrabacionPodcastPageState();
}

class _TareaDosGrabacionPodcastPageState
    extends State<TareaDosGrabacionPodcastPage> {
  final _controller = TareaDosGrabacionPodcastController();

  final _formKey = GlobalKey<FormState>();
  final pageController = PageController();

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();

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
      initialVideoId: 'Ke0nMCBVFRw',
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
          StringsGrabacionPodcast.titleTareaDosGrabacionPodcast,
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
                focusNode1.requestFocus();
              }
              setState(() {
                pageChanged = index;
              });
            },
            controller: pageController,
            children: [
              IntroUnoTareaDosGrabacionPodcastPage(
                controller: _controller,
              ),
              IntroDosTareaDosGrabacionPodcastPage(
                controller: youTubeController,
                listener: listener,
              ),
              const IntroTresTareaDosGrabacionPodcastPage(),
              QuestionGrabacionPodcastOne(
                controller: _controller,
                focusNodeList: [
                  focusNode1,
                  focusNode2,
                  focusNode3,
                ],
                controllerList: [
                  textController1,
                  textController2,
                  textController3,
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
                      onPressed: () {
                        setState(() {
                          if (pageChanged == 1) {
                            youTubeController.addListener(listener);
                          } else {
                            youTubeController.removeListener(listener);
                          }
                        });
                        deactivate();
                        if (textController1.text.isEmpty ||
                            textController2.text.isEmpty ||
                            textController3.text.isEmpty ||
                            _controller.studentGroup.length <= 1) {
                          showToast(
                            color: ThemeColors.red,
                            '''Vuelve y ingrese tuja respuesta correctamente y sus compañeros''',
                          );
                        } else {
                          final respostas = _controller.makeAnswersList([
                            textController1.text,
                            textController2.text,
                            textController3.text,
                          ]);
                          setState(() {
                            loading = true;
                          });
                          Future.delayed(Duration(milliseconds: 2000)).then(
                            (value) => Navigator.pushNamed(
                              context,
                              '/pDos_grabacionPodcast_menu',
                            ),
                          );
                          _controller.sendAnswers(
                            currentUser,
                            respostas,
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
