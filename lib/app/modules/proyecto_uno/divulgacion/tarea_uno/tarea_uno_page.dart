import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_uno/divulgacion/tarea_uno/question_one_divulgacao.dart';
import 'package:proyectemos/app/modules/proyecto_uno/divulgacion/tarea_uno/tarea_uno_controller.dart';
import 'package:proyectemos/services/toast_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../utils/get_user.dart';
import 'intro_tareas_divulgacao_dos.dart';
import 'intro_tareas_divulgacao_one.dart';

class TareaDivulgacaoPage extends StatefulWidget {
  const TareaDivulgacaoPage({Key? key}) : super(key: key);

  @override
  State<TareaDivulgacaoPage> createState() => _TareaDivulgacaoPageState();
}

class _TareaDivulgacaoPageState extends State<TareaDivulgacaoPage> {
  final _controller = DivulgacaoController();
  bool loading = false;

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
          Strings.titleDivulgacionUno,
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
          const IntroTareaUnoDivulgacaoPage(),
          const IntroTareaDosDivulgacaoPage(),
          QuestionDivulgacaoOne(
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
                            MaterialStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () async {
                        final currentUser = getCurrentUser(context);

                        if (_controller.pickedFile == null) {
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
                                  '/proyecto_uno',
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
