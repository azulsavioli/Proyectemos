import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_tres/la_sociedad/question_four.dart';
import 'package:proyectemos/app/modules/proyecto_tres/la_sociedad/question_one.dart';
import 'package:proyectemos/app/modules/proyecto_tres/la_sociedad/question_three.dart';
import 'package:proyectemos/app/modules/proyecto_tres/la_sociedad/question_two.dart';
import 'package:proyectemos/providers/record_audio_provider_la_sociedad_impl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../services/storage_service.dart';
import '../../../../services/toast_services.dart';
import '../../../../utils/get_user.dart';
import 'intro_la_sociedad.dart';
import 'la_sociedade_controller.dart';

class LaSociedadPage extends StatefulWidget {
  const LaSociedadPage({super.key});

  @override
  State<LaSociedadPage> createState() => _LaSociedadPageState();
}

class _LaSociedadPageState extends State<LaSociedadPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageService storageService = StorageService();

  final isAudioFinish = RecordAudioLaSociedadProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioLaSociedadProviderImpl.recordingsPaths;
  final _laSociedadController = LaSociedadController();

  final pageController = PageController();

  int pageChanged = 0;
  bool loading = false;

  late YoutubePlayerController youTubeControllerVideo1;
  late YoutubePlayerController youTubeControllerVideo2;
  late YoutubePlayerController youTubeControllerVideo3;

  final double volume = 100;
  final bool muted = false;

  final bool isPlayer1Ready = false;
  final bool isPlayer2Ready = false;
  final bool isPlayer3Ready = false;

  late PlayerState playerState1;
  late PlayerState playerState2;
  late PlayerState playerState3;

  late YoutubeMetaData videoMetaData1;
  late YoutubeMetaData videoMetaData2;
  late YoutubeMetaData videoMetaData3;

  void listener1() {
    if (isPlayer1Ready &&
        mounted &&
        !youTubeControllerVideo1.value.isFullScreen) {
      setState(() {
        playerState1 = youTubeControllerVideo1.value.playerState;
        videoMetaData1 = youTubeControllerVideo1.metadata;
      });
    }
  }

  void listener2() {
    if (isPlayer2Ready &&
        mounted &&
        !youTubeControllerVideo2.value.isFullScreen) {
      setState(() {
        playerState2 = youTubeControllerVideo2.value.playerState;
        videoMetaData2 = youTubeControllerVideo2.metadata;
      });
    }
  }

  void listener3() {
    if (isPlayer3Ready &&
        mounted &&
        !youTubeControllerVideo3.value.isFullScreen) {
      setState(() {
        playerState3 = youTubeControllerVideo3.value.playerState;
        videoMetaData3 = youTubeControllerVideo3.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    youTubeControllerVideo1 = YoutubePlayerController(
      initialVideoId: 'VcCkzlP_33Q',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
      ),
    )..addListener(listener1);
    videoMetaData1 = const YoutubeMetaData();
    playerState1 = PlayerState.buffering;

    youTubeControllerVideo2 = YoutubePlayerController(
      initialVideoId: 'lcjK1P3kuGo',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
      ),
    )..addListener(listener2);
    videoMetaData2 = const YoutubeMetaData();
    playerState2 = PlayerState.buffering;

    youTubeControllerVideo3 = YoutubePlayerController(
      initialVideoId: 'gl6c1kLrJnU',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
      ),
    )..addListener(listener3);
    videoMetaData3 = const YoutubeMetaData();
    playerState3 = PlayerState.buffering;
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    pageController.dispose();
    youTubeControllerVideo1.dispose();
    youTubeControllerVideo2.dispose();
    youTubeControllerVideo3.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    youTubeControllerVideo1.pause();
    youTubeControllerVideo2.pause();
    youTubeControllerVideo3.pause();

    setState(() {
      pageChanged = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          Strings.titleLaSociedad,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight - 130,
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    pageChanged = index;
                  });
                },
                controller: pageController,
                children: [
                  IntroLaSociedadPage(),
                  QuestionLaSociedadTareaUno(
                    controller: _laSociedadController,
                    youtubeController: youTubeControllerVideo1,
                    listener: listener1,
                  ),
                  QuestionLaSociedadTareaTwo(
                    controller: _laSociedadController,
                    youtubeController: youTubeControllerVideo2,
                    listener: listener2,
                  ),
                  QuestionLaSociedadTareaThree(
                    controller: _laSociedadController,
                    youtubeController: youTubeControllerVideo3,
                    listener: listener3,
                  ),
                  QuestionLaSociedadTareaFour(
                    controller: _laSociedadController,
                  ),
                ],
              ),
            ),
          ],
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
                        setState(() {
                          onPageChanged(pageChanged);
                        });
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
                      onPressed: () async {
                        onPageChanged(pageChanged);
                        final currentUser = getCurrentUser(context);

                        if (recordsPathList.isEmpty ||
                            recordsPathList.length < 4) {
                          showToast(
                            '''
¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!''',
                            color: ThemeColors.red,
                            textColor: ThemeColors.white,
                          );
                        } else {
                          if (recordsPathList.isNotEmpty &&
                              recordsPathList.length == 4) {
                            setState(() {
                              loading = true;
                            });
                            await _laSociedadController.sendAnswers(
                                currentUser, recordsPathList);
                            showToast(Strings.tareaConcluida);
                            Navigator.pushNamed(
                              context,
                              '/proyecto_tres',
                            );
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
                          onPageChanged(pageChanged);
                        });
                        if (pageChanged == 4) {
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
