import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_dos/como_crear_podcast/tarea_uno/question_como_crear_podcast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/storage_service.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'controller_uno_como_crear_podcast.dart';
import 'intro_tarea_one_como_crear_podcast.dart';

class TareaUnoEscucharPodcast extends StatefulWidget {
  const TareaUnoEscucharPodcast({super.key});

  @override
  State<TareaUnoEscucharPodcast> createState() =>
      _TareaUnoEscucharPodcastState();
}

class _TareaUnoEscucharPodcastState extends State<TareaUnoEscucharPodcast> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageService storageService = StorageService();
  final _controller = ControllerEscucharPodcast();

  final textControllerOne = TextEditingController();
  final textControllerTwo = TextEditingController();
  final textControllerThree = TextEditingController();
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  bool loading = false;

  final pageController = PageController();

  int pageChanged = 0;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.dispose();
  }

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
          Strings.titleEscucharPodcast,
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
          const IntroTareaUnoComoCrearPodcastPage(),
          QuestionComoCrearPodcast(
            focusNodeList: [focusNode1, focusNode2, focusNode3],
            textControllerList: [
              textControllerOne,
              textControllerTwo,
              textControllerThree
            ],
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
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () async {
                        final currentUser = getCurrentUser(context);

                        if (textControllerOne.text.isEmpty ||
                            textControllerTwo.text.isEmpty ||
                            textControllerThree.text.isEmpty) {
                          showToast(
                            color: ThemeColors.red,
                            'Vuelve y ingrese tujas respuestas correctamente',
                          );
                        } else {
                          setState(() {
                            loading = true;
                          });
                          await _controller
                              .sendAnswers(
                                currentUser,
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
