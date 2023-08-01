import 'package:flutter/material.dart';

import 'package:proyectemos/app/modules/proyecto_uno/latinoamerica/tarea_dos/step.dart';
import 'package:proyectemos/app/modules/proyecto_uno/latinoamerica/tarea_dos/tarea_dos_controller.dart';
import 'package:proyectemos/commons/strings_latinoamerica.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';

class TareaDosLatinoamericaPage extends StatefulWidget {
  const TareaDosLatinoamericaPage({Key? key}) : super(key: key);

  @override
  State<TareaDosLatinoamericaPage> createState() =>
      TareaDosLatinoamericaPageState();
}

class TareaDosLatinoamericaPageState extends State<TareaDosLatinoamericaPage> {
  final answerUnoController = TextEditingController();
  final answerDosController = TextEditingController();
  final answerTresController = TextEditingController();
  final answerQuatroController = TextEditingController();
  final answerCincoController = TextEditingController();
  final answerSeisController = TextEditingController();
  final answerSieteController = TextEditingController();
  final answerOchoController = TextEditingController();
  final answerNueveController = TextEditingController();
  final answerDiezController = TextEditingController();
  final _tareaDosController = TareaDosController();
  final formKey = GlobalKey<FormState>();

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

    final textOne = answerUnoController.text;
    final textTwo = answerDosController.text;
    final textThree = answerTresController.text;
    final textFour = answerQuatroController.text;
    final textFive = answerCincoController.text;
    final textSix = answerSeisController.text;
    final textSeven = answerSieteController.text;
    final textEight = answerOchoController.text;
    final textNine = answerNueveController.text;
    final textTen = answerDiezController.text;

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
          Strings.titleLatinoamericaUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 16),
              child: Text(
                StringsLationamerica.titleQOnePageDosLatin,
                style: ThemeText.paragraph14Gray,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Stepper(
                physics: const ClampingScrollPhysics(),
                currentStep: currentStep,
                steps: steps(
                  answerUnoController,
                  answerDosController,
                  answerTresController,
                  answerQuatroController,
                  answerCincoController,
                  answerSeisController,
                  answerSieteController,
                  answerOchoController,
                  answerNueveController,
                  answerDiezController,
                ),
                onStepContinue: () {
                  final isLastStep = currentStep == 10;

                  if (currentStep < 11 - 1) {
                    setState(() => currentStep++);
                  }

                  if (isLastStep) {
                    if (formKey.currentState!.validate() &&
                        _tareaDosController.selectedImages.length == 10) {
                      final answerList = _tareaDosController.makeAnswersList(
                        textOne,
                        textTwo,
                        textThree,
                        textFour,
                        textFive,
                        textSix,
                        textSeven,
                        textEight,
                        textNine,
                        textTen,
                      );
                      _tareaDosController
                        ..sendAnswers(currentUser, answerList)
                        ..saveTaskCompleted().then(
                          (value) => Navigator.pushNamed(
                            context,
                            '/pUno_latinoamerica_menu',
                          ),
                        );
                    } else {
                      showToast(
                        '''Selecciona una imagen de su cámara o de su archivo y escriba su descripción''',
                        color: ThemeColors.red,
                        textColor: ThemeColors.white,
                      );
                    }
                  }
                },
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                onStepCancel: () {
                  if (currentStep > 0) {
                    setState(() => currentStep--);
                  }
                  if (currentStep == 0) {
                    return;
                  } else {
                    setState(() => currentStep--);
                  }
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  final isLastStep = currentStep == 10;
                  return Row(
                    children: <Widget>[
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ThemeColors.white),
                            ),
                            onPressed: details.onStepCancel,
                            child: const Text(
                              'Volver',
                              style: TextStyle(color: ThemeColors.blue),
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(isLastStep ? 'Concluir' : 'Continuar'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
