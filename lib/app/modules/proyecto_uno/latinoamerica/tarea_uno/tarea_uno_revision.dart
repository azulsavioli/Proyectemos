import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_latinoamerica.dart';

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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return SingleChildScrollView(
      child: Padding(
        padding: isMobile ? EdgeInsets.all(24) : EdgeInsets.all(34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Text(
              '¡Revisa tus respuestas y presiona el botón enviar!',
              style: ThemeText.paragraph16BlueNormal,
            ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Text(
              StringsLationamerica.qOneLatin,
              style: isMobile ? ThemeText.paragraph16GrayNormal : ThemeText.paragraph14Gray,
            ),
            SizedBox(
              height: isMobile ? 10 : 20,
            ),
            if (controllerList[0].text.isNotEmpty)
              Text(
                controllerList[0].text,
                style: ThemeText.paragraph12Blue,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Text(
              StringsLationamerica.qTwoLatinTwo,
              style: isMobile ? ThemeText.paragraph16GrayNormal : ThemeText.paragraph14Gray,
            ),
            SizedBox(
              height: isMobile ? 10 : 20,
            ),
            if (controllerList[1].text.isNotEmpty)
              Text(
                controllerList[1].text,
                style: ThemeText.paragraph12Blue,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Text(
              StringsLationamerica.qThreeLatin,
              style: isMobile ? ThemeText.paragraph16GrayNormal : ThemeText.paragraph14Gray,
            ),
            SizedBox(
              height: isMobile ? 10 : 20,
            ),
            if (controllerList[2].text.isNotEmpty)
              Text(
                controllerList[2].text,
                style: ThemeText.paragraph12Blue,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Text(
              StringsLationamerica.qFourLatin,
              style: isMobile ? ThemeText.paragraph16GrayNormal : ThemeText.paragraph14Gray,
            ),
            SizedBox(
              height: isMobile ? 10 : 20,
            ),
            if (controllerList[3].text.isNotEmpty)
              Text(
                controllerList[3].text,
                style: ThemeText.paragraph12Blue,
              )
            else
              Text(
                'Vuelve y ingrese tuja respuesta correctamente',
                style: ThemeText.paragraph12Red,
              ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Text(
              StringsLationamerica.qFiveLatin,
              style: isMobile ? ThemeText.paragraph16GrayNormal : ThemeText.paragraph14Gray,
            ),
            SizedBox(
              height: isMobile ? 10 : 20,
            ),
            if (controllerList[4].text.isNotEmpty)
              Text(
                controllerList[4].text,
                style: ThemeText.paragraph12Blue,
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
