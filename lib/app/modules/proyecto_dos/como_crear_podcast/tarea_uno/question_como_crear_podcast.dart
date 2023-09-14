import 'package:flutter/material.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionComoCrearPodcast extends StatefulWidget {
  final List<TextEditingController> textControllerList;
  final List<FocusNode> focusNodeList;

  const QuestionComoCrearPodcast({
    super.key,
    required this.textControllerList,
    required this.focusNodeList,
  });

  @override
  State<QuestionComoCrearPodcast> createState() =>
      _QuestionComoCrearPodcastState();
}

class _QuestionComoCrearPodcastState extends State<QuestionComoCrearPodcast>
    with AutomaticKeepAliveClientMixin {
  List<TextEditingController> get textControllerList =>
      widget.textControllerList;
  List<FocusNode> get focusNodeList => widget.focusNodeList;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
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
                  'Paso 1',
                  style: ThemeText.paragraph14Gray,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  focusNode: focusNodeList[0],
                  textInputAction: TextInputAction.next,
                  hint: 'Respuesta',
                  controller: textControllerList[0],
                  keyboardType: TextInputType.text,
                  validatorVazio: 'Ingrese tuja respuesta correctamente',
                  validatorMenorqueNumero:
                      'Su respuesta debe tener al menos 3 caracteres',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Paso 2',
                  style: ThemeText.paragraph14Gray,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  focusNode: focusNodeList[1],
                  textInputAction: TextInputAction.next,
                  hint: 'Respuesta',
                  controller: textControllerList[1],
                  keyboardType: TextInputType.text,
                  validatorVazio: 'Ingrese tuja respuesta correctamente',
                  validatorMenorqueNumero:
                      'Su respuesta debe tener al menos 3 caracteres',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Paso 3',
                  style: ThemeText.paragraph14Gray,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  focusNode: focusNodeList[2],
                  textInputAction: TextInputAction.next,
                  hint: 'Respuesta',
                  controller: textControllerList[2],
                  keyboardType: TextInputType.text,
                  validatorVazio: 'Ingrese tuja respuesta correctamente',
                  validatorMenorqueNumero:
                      'Su respuesta debe tener al menos 3 caracteres',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
