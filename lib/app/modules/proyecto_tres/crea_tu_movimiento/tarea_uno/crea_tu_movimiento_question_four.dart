import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_crea_tu_movimiento.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionFourCreaTuMovimiento extends StatefulWidget {
  final TextEditingController controllerList;
  final FocusNode focusNodeList;

  const QuestionFourCreaTuMovimiento({
    Key? key,
    required this.controllerList,
    required this.focusNodeList,
  }) : super(key: key);

  @override
  State<QuestionFourCreaTuMovimiento> createState() =>
      _QuestionFourCreaTuMovimientoState();
}

class _QuestionFourCreaTuMovimientoState
    extends State<QuestionFourCreaTuMovimiento> {
  TextEditingController get controllerList => widget.controllerList;
  FocusNode get focusNodeList => widget.focusNodeList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              StringsCreaTuMovimiento.preguntaCuatro,
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              focusNode: focusNodeList,
              textInputAction: TextInputAction.next,
              hint: 'Respuesta',
              controller: controllerList,
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
      ),
    );
  }
}
