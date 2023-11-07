import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_radio_button.dart';
import 'tarea_uno_controller.dart';

class QuestionQueEsUnaEncuestaOne extends StatefulWidget {
  final QueEsUnaEncuestaController controller;

  const QuestionQueEsUnaEncuestaOne({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionQueEsUnaEncuestaOne> createState() =>
      _QuestionQueEsUnaEncuestaOneState();
}

class _QuestionQueEsUnaEncuestaOneState
    extends State<QuestionQueEsUnaEncuestaOne>
    with AutomaticKeepAliveClientMixin {
  QueEsUnaEncuestaController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsLaEncuesta.questionOneLaEncuestaTareaUno,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomRadioButton(
            firstChoise: 'Si',
            secondChoise: 'No',
            onSelected: (value) {
              _controller.answer1 = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
