import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'intro_dos_tareas_creacion_encuesta.dart';
import 'intro_one_tarea_creacion_encuesta.dart';
import 'tarea_creacion_encuesta.dart';
import 'tarea_uno_controller.dart';

class PDosCreacionEncuesta extends StatefulWidget {
  const PDosCreacionEncuesta({Key? key}) : super(key: key);

  @override
  State<PDosCreacionEncuesta> createState() => _PDosCreacionEncuestaState();
}

class _PDosCreacionEncuestaState extends State<PDosCreacionEncuesta> {
  final _controller = CreacionEncuestaController();
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
          Strings.titleCreacionEncuesta,
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
          IntroTareaUnoCreacionEncuestaPage(
            controller: _controller,
          ),
          const IntroTareaDosCreacionEncuestaPage(),
          TareaCreacionEncuestaPage(
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
                      onPressed: () {
                        final currentUser = getCurrentUser(context);
                        if (_controller.pickedFile == null ||
                            _controller.files.isEmpty ||
                            _controller.studentGroup.length <= 1) {
                          showToast(
                            '''
¡No se puede enviar la respuesta! Selecione o archivo y haz clic en enviar!
''',
                            color: ThemeColors.red,
                            textColor: ThemeColors.white,
                          );
                        } else {
                          setState(() {
                            loading = true;
                          });
                          Future.delayed(Duration(milliseconds: 2000)).then(
                            (value) => Navigator.pushNamed(
                              context,
                              '/pDos_creacionEncuesta_menu',
                            ),
                          );
                          _controller.sendAnswers(
                            currentUser,
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
