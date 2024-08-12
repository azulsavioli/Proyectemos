import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_movimientos_sociales.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'intro_movimientos_sociales_one.dart';
import 'intro_movimientos_sociales_three.dart';
import 'intro_movimientos_sociales_two.dart';
import 'movimientos_sociales_controller.dart';
import 'question_movimientos_sociales_four.dart';

class MovimientosSocialesTareaUno extends StatefulWidget {
  const MovimientosSocialesTareaUno({super.key});

  @override
  State<MovimientosSocialesTareaUno> createState() =>
      _MovimientosSocialesTareaUnoState();
}

class _MovimientosSocialesTareaUnoState
    extends State<MovimientosSocialesTareaUno> {
  late SharedPreferences sharedPreferences;
  String studentSchoolInfo = '';
  String studentClassRoomInfo = '';
  final _controller = MovimientosSocialesController();
  final pageController = PageController();
  bool loading = false;
  int pageChanged = 0;

  @override
  void initState() {
    super.initState();
    _controller.randomMovimiento();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

    return Scaffold(
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
          StringsMovimientosSociales.title,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              pageChanged = index;
            });
          },
          controller: pageController,
          children: [
            IntroUnoMovimientosSocialesPage(),
            IntroDosMovimientosSocialesPage(
              controller: _controller,
            ),
            IntroTresMovimientosSocialesPage(),
            IntroFourMovimientosSocialesPage(
              controller: _controller,
            ),
          ],
        ),
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
                        if (_controller.studentGroup.length <= 0 ||
                            _controller.pickedFile == null) {
                          showToast(
                            '''Selecciona el video correctamente y sus compañeros''',
                            color: ThemeColors.red,
                            textColor: ThemeColors.white,
                          );
                        } else {
                          setState(() {
                            loading = true;
                          });
                          Future.delayed(Duration(milliseconds: 2000)).then(
                            (value) {
                              if (mounted) {
                                _controller.sendAnswers(
                                  currentUser,
                                );
                                Navigator.pushNamed(
                                  context,
                                  '/pTres_movimientosSociales_menu',
                                );
                              }
                            },
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
