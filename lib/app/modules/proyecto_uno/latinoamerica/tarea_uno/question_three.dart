import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_latinoamerica.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionLatinoamericaThree extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const QuestionLatinoamericaThree({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<QuestionLatinoamericaThree> createState() =>
      _QuestionLatinoamericaThreeState();
}

class _QuestionLatinoamericaThreeState
    extends State<QuestionLatinoamericaThree> {
  TextEditingController get controller => widget.controller;
  FocusNode get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return Padding(
      padding: isMobile ? EdgeInsets.all(24) : EdgeInsets.all(34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsLationamerica.qThreeLatin,
            style: isMobile
                ? ThemeText.paragraph16GrayNormal
                : ThemeText.paragraph14Gray,
          ),
          SizedBox(
            height: isMobile ? 20 : 30,
          ),
          CustomTextFormField(
            focusNode: focusNode,
            textInputAction: TextInputAction.next,
            hint: 'Respuesta',
            controller: controller,
            keyboardType: TextInputType.text,
            validatorVazio: 'Ingrese tuja respuesta correctamente',
            validatorMenorqueNumero:
                'Su respuesta debe tener al menos 3 caracteres',
          ),
          SizedBox(
            height: isMobile ? 20 : 60,
          ),
        ],
      ),
    );
  }
}
