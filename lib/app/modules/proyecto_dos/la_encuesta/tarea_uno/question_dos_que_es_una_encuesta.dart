import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_radio_button.dart';
import 'tarea_uno_controller.dart';

class QuestionQueEsUnaEncuestaDos extends StatefulWidget {
  final QueEsUnaEncuestaController controller;

  const QuestionQueEsUnaEncuestaDos({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionQueEsUnaEncuestaDos> createState() =>
      _QuestionQueEsUnaEncuestaDosState();
}

class _QuestionQueEsUnaEncuestaDosState
    extends State<QuestionQueEsUnaEncuestaDos>
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
            StringsLaEncuesta.questionTwoLaEncuestaTareaUno,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomRadioButton(
            onSelected: (value) {
              _controller.answer2 = value;
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
