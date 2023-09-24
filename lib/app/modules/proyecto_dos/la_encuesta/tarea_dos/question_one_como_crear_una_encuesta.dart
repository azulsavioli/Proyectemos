import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionComoCrearUnaEncuestaOne extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const QuestionComoCrearUnaEncuestaOne({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<QuestionComoCrearUnaEncuestaOne> createState() =>
      _QuestionComoCrearUnaEncuestaOneState();
}

class _QuestionComoCrearUnaEncuestaOneState
    extends State<QuestionComoCrearUnaEncuestaOne> {
  TextEditingController get controller => widget.controller;
  FocusNode get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsLaEncuesta.questionOneLaEncuestaTareaDos,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            focusNode: focusNode,
            textInputAction: TextInputAction.none,
            hint: 'Respuesta',
            controller: controller,
            keyboardType: TextInputType.text,
            validatorVazio: 'Ingrese tuja respuesta correctamente',
            validatorMenorqueNumero:
                'Su respuesta debe tener al menos 3 caracteres',
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
