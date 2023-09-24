import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionQueEsUnaEncuestaTres extends StatefulWidget {
  final TextEditingController textController;
  final FocusNode focusNode;

  const QuestionQueEsUnaEncuestaTres({
    super.key,
    required this.textController,
    required this.focusNode,
  });

  @override
  State<QuestionQueEsUnaEncuestaTres> createState() =>
      _QuestionQueEsUnaEncuestaTresState();
}

class _QuestionQueEsUnaEncuestaTresState
    extends State<QuestionQueEsUnaEncuestaTres>
    with AutomaticKeepAliveClientMixin {
  TextEditingController get textController => widget.textController;
  FocusNode get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                StringsLaEncuesta.questionThreeLaEncuestaTareaUno,
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                hint: 'Respuesta',
                controller: textController,
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
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
