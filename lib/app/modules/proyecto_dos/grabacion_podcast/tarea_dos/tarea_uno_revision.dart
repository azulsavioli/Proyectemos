import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';

class RevisionQuestionsGrabacionPodcast extends StatefulWidget {
  final List<TextEditingController> controllerList;

  const RevisionQuestionsGrabacionPodcast({
    Key? key,
    required this.controllerList,
  }) : super(key: key);

  @override
  State<RevisionQuestionsGrabacionPodcast> createState() =>
      _RevisionQuestionsGrabacionPodcastState();
}

class _RevisionQuestionsGrabacionPodcastState
    extends State<RevisionQuestionsGrabacionPodcast> {
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
              '¡Revisa tus respuestas y presiona el botón enviar!',
              style: ThemeText.h3title20BlueNormal,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              StringsLaEncuesta.questionOneLaEncuestaTareaDos,
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
              StringsLaEncuesta.questionTwoLaEncuestaTareaDos,
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
              StringsLaEncuesta.questionThreeLaEncuestaTareaDos,
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
          ],
        ),
      ),
    );
  }
}
