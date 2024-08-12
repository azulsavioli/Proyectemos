import 'package:flutter/material.dart';
import 'package:proyectemos/services/toast_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings_conoces_podcast.dart';
import '../../../../../commons/styles.dart';
import '../../../../../providers/record_audio_provider_conoces_podcast_impl.dart';
import '../../../../../utils/get_user.dart';
import 'question_dos_conoces_podcast.dart';
import 'question_one_conoces_podcast.dart';
import 'question_quatro_conoces_podcast.dart';
import 'question_tres_conoces_podcast.dart';
import 'tarea_uno_controller.dart';

class PDosConocesPodcast extends StatefulWidget {
  const PDosConocesPodcast({Key? key}) : super(key: key);

  @override
  State<PDosConocesPodcast> createState() => _PDosConocesPodcastState();
}

class _PDosConocesPodcastState extends State<PDosConocesPodcast> {
  final _controller = ConocesPodcastController();
  final isAudioFinish = RecordAudioConocesPodcastProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioConocesPodcastProviderImpl.recordingsPaths;
  bool loading = false;

  final formKey = GlobalKey<FormState>();
  final pageController = PageController();
  final focusNode1 = FocusNode();
  final textEditingController1 = TextEditingController();
  final focusNode2 = FocusNode();
  final textEditingController2 = TextEditingController();

  int pageChanged = 0;

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
        title: Text(
          StringsConocesPodcast.titleConocesPodcastUno,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
          });
        },
        controller: pageController,
        children: [
          QuestionConocesPodcastOne(
            controller: _controller,
          ),
          QuestionConocesPodcastDos(
            controller: _controller,
          ),
          QuestionConocesPodcastTres(
            focusNode: focusNode1,
            textController: textEditingController1,
            controller: _controller,
          ),
          QuestionConocesPodcastQuatro(
            focusNode: focusNode2,
            textController: textEditingController2,
            controller: _controller,
          ),
        ],
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
                        final currentUser = getCurrentUser(context);

                        if (_controller.isAccessible!) {
                          if (textEditingController1.text.isEmpty ||
                              textEditingController2.text.isEmpty &&
                                  _controller.answer1 == '' ||
                              _controller.answer2 == '') {
                            showToast(
                              '''
¡No se puede enviar la respuesta! Selecione las opciones, escribe las respostas y haz clic en enviar!''',
                              color: ThemeColors.red,
                              textColor: ThemeColors.white,
                            );
                          } else {
                            if (textEditingController1.text.isNotEmpty &&
                                    textEditingController2.text.isNotEmpty &&
                                    _controller.answer1 != '' ||
                                _controller.answer2 != '') {
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
                                    );

                                    _controller.sendAnswersText(
                                      currentUser,
                                      respostas,
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      '/pDos_conocesPodcast_menu',
                                    );
                                  }
                                },
                              );
                            }
                          }
                        } else {
                          if (recordsPathList.isEmpty ||
                              recordsPathList.length < 2 &&
                                  _controller.answer1 == '' ||
                              _controller.answer2 == '') {
                            showToast(
                              '''
¡No se puede enviar la respuesta! Selecione las opciones, graba los audios y haz clic en enviar!''',
                              color: ThemeColors.red,
                              textColor: ThemeColors.white,
                            );
                          } else {
                            if (recordsPathList.isNotEmpty &&
                                    recordsPathList.length == 2 &&
                                    _controller.answer1 != '' ||
                                _controller.answer2 != '') {
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
                                      '/pDos_conocesPodcast_menu',
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
