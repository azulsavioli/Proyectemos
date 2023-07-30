import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings_latinoamerica.dart';

class RevisionQuestionsLatinoamerica extends StatefulWidget {
  final List<TextEditingController> controllerList;

  const RevisionQuestionsLatinoamerica({
    Key? key,
    required this.controllerList,
  }) : super(key: key);

  @override
  State<RevisionQuestionsLatinoamerica> createState() =>
      _RevisionQuestionsLatinoamericaState();
}

class _RevisionQuestionsLatinoamericaState
    extends State<RevisionQuestionsLatinoamerica> {
  List<TextEditingController> get controllerList => widget.controllerList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              '¡Revise sus respuestas y presione el botón enviar!',
              style: ThemeText.h3title20BlueNormal,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              StringsLationamerica.qOneLatin,
              style: ThemeText.paragraph16GrayNormal,
            ),
            if (controllerList[0].text.isNotEmpty)
              Text(
                controllerList[0].text,
                style: ThemeText.paragraph12BlueBold,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            const SizedBox(
              height: 15,
            ),
            Text(
              StringsLationamerica.qTwoLatin,
              style: ThemeText.paragraph16GrayNormal,
            ),
            if (controllerList[1].text.isNotEmpty)
              Text(
                controllerList[1].text,
                style: ThemeText.paragraph12BlueBold,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            const SizedBox(
              height: 15,
            ),
            Text(
              StringsLationamerica.qThreeLatin,
              style: ThemeText.paragraph16GrayNormal,
            ),
            if (controllerList[2].text.isNotEmpty)
              Text(
                controllerList[2].text,
                style: ThemeText.paragraph12BlueBold,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            const SizedBox(
              height: 15,
            ),
            Text(
              StringsLationamerica.qFourLatin,
              style: ThemeText.paragraph16GrayNormal,
            ),
            if (controllerList[3].text.isNotEmpty)
              Text(
                controllerList[3].text,
                style: ThemeText.paragraph12BlueBold,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            const SizedBox(
              height: 15,
            ),
            Text(
              StringsLationamerica.qFiveLatin,
              style: ThemeText.paragraph16GrayNormal,
            ),
            if (controllerList[4].text.isNotEmpty)
              Text(
                controllerList[4].text,
                style: ThemeText.paragraph12BlueBold,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
          ],
        ),
      ),
    );
  }
}
