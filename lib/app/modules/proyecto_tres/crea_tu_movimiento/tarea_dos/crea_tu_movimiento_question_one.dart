import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_crea_tu_movimiento.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionOneCreaTuMovimiento extends StatefulWidget {
  final List<TextEditingController> controllerList;
  final List<FocusNode> focusNodeList;

  const QuestionOneCreaTuMovimiento({
    Key? key,
    required this.controllerList,
    required this.focusNodeList,
  }) : super(key: key);

  @override
  State<QuestionOneCreaTuMovimiento> createState() =>
      _QuestionOneCreaTuMovimientoState();
}

class _QuestionOneCreaTuMovimientoState
    extends State<QuestionOneCreaTuMovimiento> {
  List<TextEditingController> get controllerList => widget.controllerList;
  List<FocusNode> get focusNodeList => widget.focusNodeList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              StringsCreaTuMovimiento.tareaDos,
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Nombre del movimiento',
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              focusNode: focusNodeList[0],
              textInputAction: TextInputAction.next,
              hint: 'Respuesta',
              controller: controllerList[0],
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 3 caracteres',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Link para el movimiento',
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              focusNode: focusNodeList[1],
              textInputAction: TextInputAction.next,
              hint: 'Respuesta',
              controller: controllerList[1],
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
