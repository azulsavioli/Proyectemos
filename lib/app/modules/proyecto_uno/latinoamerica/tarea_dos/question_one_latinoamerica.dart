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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;
    super.build(context);

    return Padding(
      padding: isMobile ? EdgeInsets.all(24) : EdgeInsets.all(34),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    isMobile,
                  ),
                  onStepContinue: () {
                    if (_controller.currentStep < 5 - 1) {
                      if (mounted) {
                        setState(() => _controller.currentStep++);
                        widget.onUpdate();
                      }
                    }
                  },
                  onStepTapped: (step) {
                    if (mounted) {
                      setState(() {
                        _controller.currentStep = step;
                        widget.onUpdate();
                      });
                    }
                  },
                  onStepCancel: () {
                    if (_controller.currentStep > 0) {
                      if (mounted) {
                        setState(() => _controller.currentStep--);
                        widget.onUpdate();
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
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                minimumSize: Size(100, isMobile ? 50 : 80),
                              ),
                              onPressed: details.onStepCancel != null
                                  ? () {
                                      details.onStepCancel!();
                                      widget.onUpdate();
                                    }
                                  : null,
                              child:  Text(
                                'Volver',
                                style: isMobile ? TextStyle(color:ThemeColors.blue) :
                                TextStyle(
                                    color: ThemeColors.blue,
                                    fontSize: 26,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (_controller.isLastStep == _controller.currentStep)
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, isMobile ? 50 : 80),
                              ),
                              onPressed: details.onStepCancel != null
                                  ? () {
                                      details.onStepCancel!();
                                      widget.onUpdate();
                                    }
                                  : null,
                              child:  Text(
                                'Volver',
                                style: isMobile ? TextStyle(color:ThemeColors.blue) :
                                TextStyle(
                                    color: ThemeColors.blue,
                                    fontSize: 26,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, isMobile ? 50 : 80),
                                  backgroundColor: ThemeColors.blue,
                                ),
                                onPressed: details.onStepContinue != null
                                    ? () {
                                        details.onStepContinue!();
                                        widget.onUpdate();
                                      }
                                    : null,
                                child: Text('Continuar',
                                    style: isMobile ? TextStyle(color:ThemeColors.white) :
                                  TextStyle(
                                    color: ThemeColors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.normal),
                                )),
                          ),
                        if (_controller.isLastStep == _controller.currentStep)
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, isMobile ? 50 : 80),
                              ),
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
                                style: isMobile ? TextStyle(color:ThemeColors.blue) :
                                TextStyle(
                                    color: ThemeColors.blue,
                                    fontSize: 26,
                                    fontWeight: FontWeight.normal),
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
