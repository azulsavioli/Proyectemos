import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_uno/latinoamerica/tarea_dos/tarea_dos_controller.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/step/step.dart';

class QuestionLatinoamericaTareaDos extends StatefulWidget {
  final LatinoamericaTareaDosController controller;
  final Function onUpdate;

  const QuestionLatinoamericaTareaDos({
    Key? key,
    required this.controller,
    required this.onUpdate,
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _controller.formKey,
                child: Stepper(
                  connectorColor: WidgetStateProperty.resolveWith(
                      (states) => ThemeColors.blue),
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
                      if (mounted) {
                        setState(() => _controller.currentStep++);
                        widget.onUpdate(); // Chamando o onUpdate
                      }
                    }
                  },
                  onStepTapped: (step) {
                    if (mounted) {
                      setState(() {
                        _controller.currentStep = step;
                        widget.onUpdate(); // Chamando o onUpdate
                      });
                    }
                  },
                  onStepCancel: () {
                    if (_controller.currentStep > 0) {
                      if (mounted) {
                        setState(() => _controller.currentStep--);
                        widget.onUpdate(); // Chamando o onUpdate
                      }
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
                              style: ButtonStyle(),
                              onPressed: details.onStepCancel != null
                                  ? () {
                                      details.onStepCancel!();
                                      widget.onUpdate(); // Chamando o onUpdate
                                    }
                                  : null,
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
                              style: ButtonStyle(),
                              onPressed: details.onStepCancel != null
                                  ? () {
                                      details.onStepCancel!();
                                      widget.onUpdate(); // Chamando o onUpdate
                                    }
                                  : null,
                              child: const Text(
                                'Volver',
                                style: TextStyle(color: ThemeColors.blue),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue != null
                                  ? () {
                                      details.onStepContinue!();
                                      widget.onUpdate();
                                    }
                                  : null,
                              child: const Text('Continuar',
                                  style: TextStyle(color: ThemeColors.blue)),
                            ),
                          ),
                        if (_controller.isLastStep == _controller.currentStep)
                          SizedBox(
                            width: 5,
                          ),
                        if (_controller.isLastStep == _controller.currentStep)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_controller.currentStep < 5 - 1) {
                                  if (mounted) {
                                    setState(() => _controller.currentStep++);
                                    widget.onUpdate();
                                  }
                                } else {
                                  widget.onUpdate();
                                }
                              },
                              child: Text(
                                'Concluir',
                                style: TextStyle(color: ThemeColors.blue),
                              ),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
