import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../providers/record_audio_provider_tu_alrededor_impl.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'question_tu_alrededor_five.dart';
import 'question_tu_alrededor_four.dart';
import 'question_tu_alrededor_one.dart';
import 'question_tu_alrededor_seven.dart';
import 'question_tu_alrededor_six.dart';
import 'question_tu_alrededor_three.dart';
import 'question_tu_alrededor_two.dart';
import 'tu_alrededor_controller.dart';

class TuAlrededor extends StatefulWidget {
  const TuAlrededor({super.key});

  @override
  State<TuAlrededor> createState() => _TuAlrededorState();
}

class _TuAlrededorState extends State<TuAlrededor> {
  final isAudioFinish = RecordAudioTuAlrededorProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioTuAlrededorProviderImpl.recordingsPaths;
  final _controller = TuAlrededorController();
  bool loading = false;

  final formKey = GlobalKey<FormState>();
  final pageController = PageController();

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
          Strings.titleTuAlrededor,
          style: ThemeText.paragraph14WhiteBold,
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
                            WidgetStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () async {
                        final currentUser = getCurrentUser(context);

                        if (recordsPathList.isEmpty ||
                            recordsPathList.length < 7) {
                          showToast(
                            '''
¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!
''',
                            color: ThemeColors.red,
                            textColor: ThemeColors.white,
                          );
                        } else {
                          if (recordsPathList.isNotEmpty &&
                              recordsPathList.length == 7) {
                            setState(() {
                              loading = true;
                            });
                            Future.delayed(Duration(milliseconds: 2000)).then(
                              (value) => Navigator.pushNamed(
                                context,
                                '/pTres_tuAlrededor_menu',
                              ),
                            );
                            _controller.sendAnswers(
                              currentUser,
                              recordsPathList,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  130, // altura da tela menos a altura da appbar e bottomSheet
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    pageChanged = index;
                  });
                },
                controller: pageController,
                children: [
                  QuestionTuAlrededorOne(
                    controller: _controller,
                  ),
                  QuestionTuAlrededorTwo(
                    controller: _controller,
                  ),
                  QuestionTuAlrededorThree(
                    controller: _controller,
                  ),
                  QuestionTuAlrededorFour(
                    controller: _controller,
                  ),
                  QuestionTuAlrededorFive(
                    controller: _controller,
                  ),
                  QuestionTuAlrededorSix(
                    controller: _controller,
                  ),
                  QuestionTuAlrededorSeven(
                    controller: _controller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
