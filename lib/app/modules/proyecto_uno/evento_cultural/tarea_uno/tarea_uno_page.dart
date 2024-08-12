import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_uno/evento_cultural/tarea_uno/tarea_evento_cultural.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';

import 'intro_one_tareas_evento_cultural.dart';
import 'intro_three_tareas_evento_cultural.dart';
import 'intro_two_tareas_evento_cultural.dart';
import 'tarea_uno_controller.dart';

class PUnoEventoCulturalTareaPage extends StatefulWidget {
  const PUnoEventoCulturalTareaPage({Key? key}) : super(key: key);

  @override
  State<PUnoEventoCulturalTareaPage> createState() =>
      _PUnoEventoCulturalTareaPageState();
}

class _PUnoEventoCulturalTareaPageState
    extends State<PUnoEventoCulturalTareaPage> {
  final _controller = EventoCulturalTareaUnoController();
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  final pageController = PageController();
  int pageChanged = 0;

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          toolbarHeight: isMobile ? 60 : 110,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: ThemeColors.white, size: isMobile ? 20 : 50),
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                });
              },
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleEventoCulturalUnoFeed,
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
            const IntroTareaUnoEventoCulturalPage(),
            const IntroTareaDosEventoCulturalPage(),
            const IntroTareaTresEventoCulturalPage(),
            TareaUnoEventoCulturalPage(
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
                        onPressed: () {
                          final currentUser = getCurrentUser(context);

                          if (_controller.recordsPathList.isEmpty) {
                            showToast(
                              '''
      ¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!
      ''',
                              color: ThemeColors.red,
                              textColor: ThemeColors.white,
                            );
                          } else {
                            setState(() {
                              loading = true;
                            });
                            if (_controller.recordsPathList.isNotEmpty &&
                                _controller.recordsPathList.length == 1) {
                              Future.delayed(Duration(milliseconds: 2000)).then(
                                (value) {
                                  if (mounted) {
                                    Navigator.pushNamed(
                                      context,
                                      '/pUno_evento_cultural_menu',
                                    );
                                    _controller.sendAnswers(
                                      currentUser,
                                    );
                                  }
                                },
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Compartir',
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
      ),
    );
  }
}
