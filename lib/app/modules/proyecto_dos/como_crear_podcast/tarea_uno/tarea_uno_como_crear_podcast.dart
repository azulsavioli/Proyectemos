import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_dos/como_crear_podcast/tarea_uno/question_como_crear_podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'controller_uno_como_crear_podcast.dart';
import 'final_intro_como_crear_podcast_page_dos.dart';
import 'final_intro_como_crear_podcast_page_uno.dart';
import 'intro_como_crear_podcast_page_cinco_accessible.dart';
import 'intro_como_crear_podcast_page_cuatro_accessible.dart';
import 'intro_como_crear_podcast_page_dos_accessible.dart';
import 'intro_como_crear_podcast_page_one.dart';
import 'intro_como_crear_podcast_page_one_accessible.dart';
import 'intro_como_crear_podcast_page_seis_accessible.dart';
import 'intro_como_crear_podcast_page_siete_accessible.dart';
import 'intro_como_crear_podcast_page_tres_accessible.dart';

class TareaUnoEscucharPodcast extends StatefulWidget {
  const TareaUnoEscucharPodcast({super.key});

  @override
  State<TareaUnoEscucharPodcast> createState() =>
      _TareaUnoEscucharPodcastState();
}

class _TareaUnoEscucharPodcastState extends State<TareaUnoEscucharPodcast> {
  late final _controller = ControllerEscucharPodcast();

  final textControllerOne = TextEditingController();
  final textControllerTwo = TextEditingController();
  final textControllerThree = TextEditingController();
  final textControllerFour = TextEditingController();
  final textControllerFive = TextEditingController();
  final textControllerSix = TextEditingController();

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  late FocusNode focusNode6;
  late bool isAllFilesFilleds;
  bool loading = false;
  bool isAccessible = false;
  bool _accessibilityReady = false;

  final pageController = PageController();

  int pageChanged = 0;

  @override
  void initState() {
    super.initState();
    getIsAcessible();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
    isAllFilesFilleds = false;
    _setupListeners();
  }

  void _setupListeners() {
    textControllerOne.addListener(_updateIsAllFilesFilleds);
    textControllerTwo.addListener(_updateIsAllFilesFilleds);
    textControllerThree.addListener(_updateIsAllFilesFilleds);
    textControllerFour.addListener(_updateIsAllFilesFilleds);
    textControllerFive.addListener(_updateIsAllFilesFilleds);
    textControllerSix.addListener(_updateIsAllFilesFilleds);
  }

  void _updateIsAllFilesFilleds() {
    setState(() {
      isAllFilesFilleds =
          textControllerOne.text.isNotEmpty &&
          textControllerTwo.text.isNotEmpty &&
          textControllerThree.text.isNotEmpty &&
          textControllerFour.text.isNotEmpty &&
          textControllerFive.text.isNotEmpty &&
          textControllerSix.text.isNotEmpty;
    });
  }

  Future<void> getIsAcessible() async {
    final preferences = await SharedPreferences.getInstance();
    final isAccessibleOn = preferences.getBool("isAccessible");
    if (!mounted) return;
    setState(() {
      isAccessible = isAccessibleOn ?? false;
      _accessibilityReady = true;
    });
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAllFilesFilleds =
        textControllerOne.text.isNotEmpty &&
        textControllerTwo.text.isNotEmpty &&
        textControllerThree.text.isNotEmpty &&
        textControllerFour.text.isNotEmpty &&
        textControllerFive.text.isNotEmpty &&
        textControllerSix.text.isNotEmpty;

    if (!_accessibilityReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pageCount = isAccessible ? 10 : 2;
    final isLastPage = pageChanged == pageCount - 1;

    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Volver',
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromRGBO(250, 251, 250, 1)),
        title: Text(
          Strings.titleElContenidoDelPodcast,
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
        children: isAccessible
            ? [
                const IntroTareaComoCrearPodcastPageUnoAccessible(),
                const IntroTareaComoCrearPodcastPageDosAccessible(),
                const IntroTareaComoCrearPodcastPageTresAccessible(),
                const IntroTareaComoCrearPodcastPageCuatroAccessible(),
                const IntroTareaComoCrearPodcastPageCincoAccessible(),
                const IntroTareaComoCrearPodcastPageSeisAccessible(),
                const IntroTareaComoCrearPodcastPageSieteAccessible(),
                const FinalIntroTareaComoCrearPodcastPageUnoAccessible(),
                const FinalIntroTareaComoCrearPodcastPageDosAccessible(),
                QuestionComoCrearPodcast(
                  focusNodeList: [
                    focusNode1,
                    focusNode2,
                    focusNode3,
                    focusNode4,
                    focusNode5,
                    focusNode6,
                  ],
                  textControllerList: [
                    textControllerOne,
                    textControllerTwo,
                    textControllerThree,
                    textControllerFour,
                    textControllerFive,
                    textControllerSix,
                  ],
                ),
              ]
            : [
                const IntroTareaComoCrearPodcastPageUno(),
                QuestionComoCrearPodcast(
                  focusNodeList: [
                    focusNode1,
                    focusNode2,
                    focusNode3,
                    focusNode4,
                    focusNode5,
                    focusNode6,
                  ],
                  textControllerList: [
                    textControllerOne,
                    textControllerTwo,
                    textControllerThree,
                    textControllerFour,
                    textControllerFive,
                    textControllerSix,
                  ],
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: pageChanged == 0
                          ? const SizedBox(width: 48)
                          : TextButton(
                              onPressed: () {
                                pageController.previousPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Volver',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ThemeColors.gray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: pageCount,
                      effect: WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: pageCount > 4 ? 4 : 8,
                        activeDotColor: Colors.blueAccent,
                        dotColor: Colors.black26,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: isLastPage
                          ? TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  isAllFilesFilleds
                                      ? ThemeColors.blue
                                      : Colors.transparent,
                                ),
                              ),
                              onPressed: () async {
                                if (textControllerOne.text.isEmpty ||
                                    textControllerTwo.text.isEmpty ||
                                    textControllerThree.text.isEmpty ||
                                    textControllerFour.text.isEmpty ||
                                    textControllerFive.text.isEmpty ||
                                    textControllerSix.text.isEmpty) {
                                  showToast(
                                    context,
                                    'Vuelve y ingrese tujas respuestas correctamente',
                                    ThemeColors.red,
                                    ThemeColors.white,
                                  );
                                } else {
                                  final respostas = _controller.makeAnswersList(
                                    textControllerOne.text,
                                    textControllerTwo.text,
                                    textControllerThree.text,
                                    textControllerFour.text,
                                    textControllerFive.text,
                                    textControllerSix.text,
                                  );
                                  setState(() {
                                    loading = true;
                                  });
                                  Future.delayed(Duration(milliseconds: 2000))
                                      .then(
                                        (value) => Navigator.pushNamed(
                                          context,
                                          '/pDos_comoCrearPodcast_menu',
                                        ),
                                      );
                                  final currentUser = await getCurrentUser(
                                    context,
                                  );
                                  _controller.sendAnswers(
                                    context,
                                    currentUser,
                                    respostas,
                                  );
                                }
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Enviar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isAllFilesFilleds
                                        ? ThemeColors.foregroundOn(
                                            ThemeColors.blue,
                                          )
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Próximo',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ThemeColors.gray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
