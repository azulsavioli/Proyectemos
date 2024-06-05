import 'package:flutter/material.dart';
import 'package:proyectemos/utils/get_user.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../commons/styles.dart';
import '../../../../../providers/record_audio_provider_la_encuesta_tarea_uno.dart';
import '../../../../../services/toast_services.dart';
import 'question_dos_que_es_una_encuesta.dart';
import 'question_one_que_es_una_encuesta.dart';
import 'question_tres_que_es_una_encuesta.dart';
import 'tarea_uno_controller.dart';

class TareaUnoQueEsUnaEncuesta extends StatefulWidget {
  const TareaUnoQueEsUnaEncuesta({super.key});

  @override
  State<TareaUnoQueEsUnaEncuesta> createState() =>
      _TareaUnoQueEsUnaEncuestaState();
}

class _TareaUnoQueEsUnaEncuestaState extends State<TareaUnoQueEsUnaEncuesta> {
  final _controller = QueEsUnaEncuestaController();
  final isAudioFinish = RecordAudioLaEncuestaTareaUnoProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioLaEncuestaTareaUnoProviderImpl.recordingsPaths;

  bool loading = false;

  final formKey = GlobalKey<FormState>();
  final pageController = PageController();

  int pageChanged = 0;

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

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
          StringsLaEncuesta.titleTareaUnoQueEsUnaEncuesta,
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
          QuestionQueEsUnaEncuestaOne(
            controller: _controller,
          ),
          QuestionQueEsUnaEncuestaDos(
            controller: _controller,
          ),
          QuestionQueEsUnaEncuestaTres(
            controller: _controller,
          ),
        ],
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
                      count: 3,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.blueAccent,
                        dotColor: Colors.black26,
                      ),
                    ),
                  ),
                  if (pageChanged == 2)
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () async {
                        if (recordsPathList.isEmpty ||
                            _controller.answer1 == '' ||
                            _controller.answer2 == '') {
                          showToast(
                            '''
¡No se puede enviar la respuesta! Selecione las opciones, graba los audios y haz clic en guardar!''',
                            color: ThemeColors.red,
                            textColor: ThemeColors.white,
                          );
                        } else {
                          if (recordsPathList.isNotEmpty &&
                                  _controller.answer1 != '' ||
                              _controller.answer2 != '') {
                            setState(() {
                              loading = true;
                            });
                            Future.delayed(Duration(milliseconds: 2000)).then(
                              (value) => Navigator.pushNamed(
                                context,
                                '/pDos_laEncuesta_menu',
                              ),
                            );
                            _controller.sendAnswers(
                                currentUser, recordsPathList);
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
