import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'controller_dos_como_crear_podcast.dart';
import 'intro_tarea_dos_como_crear_podcast.dart';
import 'question_five_como_crear_podcast.dart';
import 'question_four_como_crear_podcast.dart';
import 'question_one_como_crear_podcast.dart';
import 'question_six_como_crear_podcast.dart';
import 'question_three_como_crear_podcast.dart';
import 'question_two_como_crear_podcast.dart';

class TareaDosCrearUnPodcast extends StatefulWidget {
  const TareaDosCrearUnPodcast({super.key});

  @override
  State<TareaDosCrearUnPodcast> createState() => _TareaDosCrearUnPodcastState();
}

class _TareaDosCrearUnPodcastState extends State<TareaDosCrearUnPodcast> {
  final _controller = ControllerCrearUnPodcast();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final pageController = PageController();

  final textControllerOne = TextEditingController();
  final textControllerTwo = TextEditingController();
  final textControllerThree = TextEditingController();
  final textControllerFour = TextEditingController();

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;

  int pageChanged = 0;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
  }

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
          Strings.titleCrearUnPodcast,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      body: Form(
        key: _formKey,
        child: PageView(
          onPageChanged: (index) {
            if (index == 0) {
              FocusScope.of(context).unfocus();
            }
            if (index == 1) {
              focusNode1.requestFocus();
            }
            if (index == 2) {
              focusNode2.requestFocus();
            }
            if (index == 3) {
              FocusScope.of(context).unfocus();
            }
            if (index == 4) {
              FocusScope.of(context).unfocus();
            }
            if (index == 5) {
              focusNode3.requestFocus();
            }
            if (index == 6) {
              focusNode4.requestFocus();
            }
            setState(() {
              pageChanged = index;
            });
          },
          controller: pageController,
          children: [
            IntroTareaDosComoCrearPodcastPage(
              controller: _controller,
            ),
            QuestionOneComoCrearPodcast(
              controller: textControllerOne,
              focusNode: focusNode1,
            ),
            QuestionTwoComoCrearPodcast(
              controller: textControllerTwo,
              focusNode: focusNode2,
            ),
            QuestionThreeComoCrearPodcast(
              controller: _controller,
            ),
            QuestionFourComoCrearPodcast(
              controller: _controller,
            ),
            QuestionFiveComoCrearPodcast(
              controller: textControllerThree,
              focusNode: focusNode3,
            ),
            QuestionSixComoCrearPodcast(
              controller: textControllerFour,
              focusNode: focusNode4,
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
                            MaterialStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () async {
                        if (textControllerOne.text.isEmpty ||
                            textControllerTwo.text.isEmpty ||
                            textControllerThree.text.isEmpty ||
                            textControllerFour.text.isEmpty ||
                            _controller.studentGroup.length <= 1) {
                          showToast(
                            color: ThemeColors.red,
                            'Vuelve y ingrese tuja respuesta correctamente',
                          );
                        } else {
                          final respostas = _controller.makeAnswersList(
                            textControllerOne.text,
                            textControllerTwo.text,
                            textControllerThree.text,
                            textControllerFour.text,
                          );
                          setState(() {
                            loading = true;
                          });
                          await _controller
                              .sendAnswers(
                                currentUser,
                                respostas,
                              )
                              .then(
                                (value) => Navigator.pushNamed(
                                  context,
                                  '/pDos_comoCrearPodcast_menu',
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
