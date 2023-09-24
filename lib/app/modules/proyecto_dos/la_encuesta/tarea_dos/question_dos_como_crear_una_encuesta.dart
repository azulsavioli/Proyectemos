import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionComoCrearUnaEncuestaDos extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const QuestionComoCrearUnaEncuestaDos({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<QuestionComoCrearUnaEncuestaDos> createState() =>
      _QuestionComoCrearUnaEncuestaDosState();
}

class _QuestionComoCrearUnaEncuestaDosState
    extends State<QuestionComoCrearUnaEncuestaDos> {
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
            StringsLaEncuesta.questionTwoLaEncuestaTareaDos,
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
