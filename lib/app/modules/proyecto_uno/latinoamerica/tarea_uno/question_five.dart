import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_latinoamerica.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionLatinoamericaFive extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const QuestionLatinoamericaFive({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<QuestionLatinoamericaFive> createState() =>
      _QuestionLatinoamericaFiveState();
}

class _QuestionLatinoamericaFiveState extends State<QuestionLatinoamericaFive> {
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
            StringsLationamerica.qFiveLatin,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            focusNode: focusNode,
            textInputAction: TextInputAction.go,
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
