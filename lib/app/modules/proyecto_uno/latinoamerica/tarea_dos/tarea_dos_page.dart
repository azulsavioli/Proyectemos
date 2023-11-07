import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_uno/latinoamerica/tarea_dos/tarea_dos_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'intro_tareas_latinoamerica.dart';
import 'question_one_latinoamerica.dart';

class PUnoLatinoamericaTareaDosPage extends StatefulWidget {
  const PUnoLatinoamericaTareaDosPage({Key? key}) : super(key: key);

  @override
  State<PUnoLatinoamericaTareaDosPage> createState() =>
      _PUnoLatinoamericaTareaDosPageState();
}

class _PUnoLatinoamericaTareaDosPageState
    extends State<PUnoLatinoamericaTareaDosPage> {
  final _controller = LatinoamericaTareaDosController();
  bool loading = false;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(_onPageViewScroll);
  }

  void _onPageViewScroll() {
    if (pageController.page == pageController.page?.round()) {}
  }

  @override
  void dispose() {
    pageController
      ..removeListener(_onPageViewScroll)
      ..dispose();
    super.dispose();
  }

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
          Strings.titleTuLatinoamerica,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          if (mounted) {
            setState(() {
              pageChanged = index;
            });
          }
        },
        controller: pageController,
        children: [
          const IntroTareaUnoLatinoamericaPage(),
          QuestionLatinoamericaTareaDos(controller: _controller),
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
                      count: 2,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.blueAccent,
                        dotColor: Colors.black26,
                      ),
                    ),
                  ),
                  if (pageChanged == 1)
                    if (_controller.selectedImages.length == 5)
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ThemeColors.blue),
                        ),
                        onPressed: () async {
                          final currentUser = getCurrentUser(context);

                          if (_controller.isLastStep == 4 && pageChanged == 1) {
                            if (_controller.formKey.currentState!.validate() &&
                                _controller.selectedImages.length == 5) {
                              setState(() {
                                loading = true;
                              });
                              final answerList = _controller.makeAnswersList(
                                _controller.answerUnoController.text,
                                _controller.answerDosController.text,
                                _controller.answerTresController.text,
                                _controller.answerQuatroController.text,
                                _controller.answerCincoController.text,
                              );
                              await _controller
                                  .sendAnswers(currentUser, answerList)
                                  .then(
                                    (value) => {
                                      if (mounted)
                                        {
                                          Navigator.pushNamed(
                                            context,
                                            '/pUno_latinoamerica_menu',
                                          ),
                                        },
                                    },
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
                          showToast(
                            color: ThemeColors.red,
                            'Vuelve y ingrese tujas respuestas correctamente',
                          );
                        },
                        child: const Text(
                          'Enviar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
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
