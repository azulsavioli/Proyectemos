import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_uno/latinoamerica/tarea_dos/tarea_dos_controller.dart';

import '../../../../../commons/styles.dart';
import 'step.dart';

class QuestionLatinoamericaTareaDos extends StatefulWidget {
  final LatinoamericaTareaDosController controller;

  const QuestionLatinoamericaTareaDos({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionLatinoamericaTareaDos> createState() =>
      _QuestionLatinoamericaTareaDosState();
}

enum OpcoesCompartilhamento { turma, todos }

class _QuestionLatinoamericaTareaDosState
    extends State<QuestionLatinoamericaTareaDos>
    with AutomaticKeepAliveClientMixin {
  LatinoamericaTareaDosController get _controller => widget.controller;
  OpcoesCompartilhamento? sendingType = OpcoesCompartilhamento.todos;

  bool isButtonDisabled = false;

  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy);
  Color buttonFileColor = ThemeColors.blue;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _controller.formKey,
              child: Stepper(
                physics: const ClampingScrollPhysics(),
                currentStep: _controller.currentStep,
                steps: steps(
                  _controller.answerUnoController,
                  _controller.answerDosController,
                  _controller.answerTresController,
                  _controller.answerQuatroController,
                  _controller.answerCincoController,
                ),
                onStepContinue: () {
                  if (_controller.currentStep < 5 - 1) {
                    setState(() => _controller.currentStep++);
                  }
                },
                onStepTapped: (step) {
                  setState(() {
                    _controller.currentStep = step;
                  });
                },
                onStepCancel: () {
                  if (_controller.currentStep > 0) {
                    setState(() => _controller.currentStep--);
                  }
                  if (_controller.currentStep == 0) {
                    return;
                  }
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Row(
                    children: <Widget>[
                      if (_controller.currentStep != 0 &&
                          _controller.isLastStep != _controller.currentStep)
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
                      if (_controller.isLastStep == _controller.currentStep)
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
                        )
                      else
                        Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: const Text('Continuar'),
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

  @override
  bool get wantKeepAlive => true;
}
