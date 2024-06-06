import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings_crea_tu_movimiento.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'crea_tu_movimiento_controller_tarea_dos.dart';
import 'crea_tu_movimiento_intro_dos.dart';
import 'crea_tu_movimiento_intro_uno.dart';
import 'crea_tu_movimiento_question_five.dart';
import 'crea_tu_movimiento_question_four.dart';
import 'crea_tu_movimiento_question_one.dart';
import 'crea_tu_movimiento_question_three.dart';
import 'crea_tu_movimiento_question_two.dart';

class CreacionDeSuMovimentoTareaUno extends StatefulWidget {
  const CreacionDeSuMovimentoTareaUno({super.key});

  @override
  State<CreacionDeSuMovimentoTareaUno> createState() =>
      _CreacionDeSuMovimentoTareaUnoState();
}

class _CreacionDeSuMovimentoTareaUnoState
    extends State<CreacionDeSuMovimentoTareaUno> {
  final _controller = CreacionDeSuMovimentoTareaUnoController();
  final _formKey = GlobalKey<FormState>();
  final pageController = PageController();

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();
  final textController4 = TextEditingController();
  final textController5 = TextEditingController();

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy, color: ThemeColors.white);
  Color buttonFileColor = ThemeColors.blue;

  int pageChanged = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
  }

  @override
  void dispose() {
    pageController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          StringsCreaTuMovimiento.title,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
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
                focusNode3.requestFocus();
              }
              if (index == 4) {
                focusNode4.requestFocus();
              }
              if (index == 5) {
                focusNode5.requestFocus();
              }
              setState(() {
                pageChanged = index;
              });
            },
            controller: pageController,
            children: [
              IntroUnoCreaTuMovimientoTareaUno(),
              IntroDosCreaTuMovimientoTareaUno(
                controller: _controller,
              ),
              QuestionOneCreaTuMovimiento(
                controllerList: textController1,
                focusNodeList: focusNode1,
              ),
              QuestionTwoCreaTuMovimiento(
                controllerList: textController2,
                focusNodeList: focusNode2,
              ),
              QuestionThreeCreaTuMovimiento(
                controllerList: textController3,
                focusNodeList: focusNode3,
              ),
              QuestionFourCreaTuMovimiento(
                controllerList: textController4,
                focusNodeList: focusNode4,
              ),
              QuestionFiveCreaTuMovimiento(
                controllerList: textController5,
                focusNodeList: focusNode5,
              ),
            ],
          ),
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
                            WidgetStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () {
                        if (textController1.text.isEmpty ||
                            textController2.text.isEmpty ||
                            textController3.text.isEmpty ||
                            textController4.text.isEmpty ||
                            textController5.text.isEmpty ||
                            _controller.studentGroup.length <= 0) {
                          showToast(
                            color: ThemeColors.red,
                            '''Vuelve y ingrese tuja respuesta correctamente y sus compañeros''',
                          );
                        } else {
                          final respostas = _controller.makeAnswersList([
                            textController1.text,
                            textController2.text,
                            textController3.text,
                            textController4.text,
                            textController5.text,
                          ]);
                          setState(() {
                            loading = true;
                          });
                          Future.delayed(Duration(milliseconds: 2000)).then(
                            (value) => Navigator.pushNamed(
                              context,
                              '/pTres_creacionDeSuMovimento_menu',
                            ),
                          );
                          _controller.sendAnswers(
                            currentUser,
                            respostas,
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
