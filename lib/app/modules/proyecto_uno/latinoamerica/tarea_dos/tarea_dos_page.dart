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

  void _onPageViewScroll() {}

  @override
  void dispose() {
    pageController
      ..removeListener(_onPageViewScroll)
      ..dispose();
    super.dispose();
  }

  int pageChanged = 0;
  bool canSubmit = false;

  void updateCanSubmit() {
    setState(() {
      canSubmit = pageChanged == 1 &&
          _controller.selectedImages.length == 5 &&
          _controller.answerUnoController.text.isNotEmpty &&
          _controller.answerDosController.text.isNotEmpty &&
          _controller.answerTresController.text.isNotEmpty &&
          _controller.answerQuatroController.text.isNotEmpty &&
          _controller.answerCincoController.text.isNotEmpty &&
          _controller.selectedImages.isNotEmpty &&
          _controller.answerCincoController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;
    final currentUser = getCurrentUser(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          toolbarHeight: isMobile ? 60 : 90,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: ThemeColors.white, size: isMobile ? 20 : 40),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
            setState(() {
              pageChanged = index;
            });
          },
          controller: pageController,
          children: [
            const IntroTareaUnoLatinoamericaPage(),
            QuestionLatinoamericaTareaDos(
              controller: _controller,
              onUpdate: updateCanSubmit,
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
                height: isMobile ? 60 : 90,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
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
                        child: Text(
                          'Volver',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 28,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 2,
                        effect: WormEffect(
                          dotHeight: isMobile ? 10 : 18,
                          dotWidth: isMobile ? 10 : 18,
                          activeDotColor: Colors.blueAccent,
                          dotColor: Colors.black26,
                        ),
                      ),
                    ),
                    if (pageChanged == 1 &&
                        _controller.selectedImages.length == 5)
                      ElevatedButton(
                        onPressed: canSubmit
                            ? () async {
                                updateCanSubmit();
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
                                Future.delayed(Duration(milliseconds: 2000))
                                    .then(
                                  (value) {
                                    if (mounted) {
                                      _controller.sendAnswers(
                                        currentUser,
                                        answerList,
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        '/pUno_latinoamerica_menu',
                                      );
                                    }
                                  },
                                );
                              }
                            : () {
                                updateCanSubmit();
                                showToast(
                                  color: ThemeColors.red,
                                  'Vuelve y ingrese tus respuestas correctamente',
                                );
                              },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              canSubmit ? ThemeColors.blue : Colors.grey),
                        ),
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 28,
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
                        child: Text(
                          'Próximo',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 28,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
