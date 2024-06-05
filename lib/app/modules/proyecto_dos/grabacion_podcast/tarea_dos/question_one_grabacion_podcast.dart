import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_grabacion_podcast.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../widgets/custom_text_form_field.dart';
import 'tarea_dos_controller.dart';

class QuestionGrabacionPodcastOne extends StatefulWidget {
  final TareaDosGrabacionPodcastController controller;
  final List<TextEditingController> controllerList;
  final List<FocusNode> focusNodeList;

  const QuestionGrabacionPodcastOne({
    Key? key,
    required this.controller,
    required this.controllerList,
    required this.focusNodeList,
  }) : super(key: key);

  @override
  State<QuestionGrabacionPodcastOne> createState() =>
      _QuestionGrabacionPodcastOneState();
}

class _QuestionGrabacionPodcastOneState
    extends State<QuestionGrabacionPodcastOne> {
  TareaDosGrabacionPodcastController get _controller => widget.controller;
  List<TextEditingController> get controllerList => widget.controllerList;
  List<FocusNode> get focusNodeList => widget.focusNodeList;
  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy, color: ThemeColors.white);
  Color buttonFileColor = ThemeColors.blue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              StringsGrabacionPodcast.descriptionThreeTareaDosGrabacionPodcast,
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Nombre del podcast',
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
              'Nombre del episodio del podcast',
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
            Text(
              'Link para el podcast',
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              focusNode: focusNodeList[2],
              textInputAction: TextInputAction.next,
              hint: 'Respuesta',
              controller: controllerList[2],
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 3 caracteres',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Logo del podcast',
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                icon: buttonFileIcon,
                onPressed: () async {
                  final file = await _controller.selectFile();
                  if (file != null) {
                    setState(() {
                      buttonFileColor = ThemeColors.green;
                      buttonFileIcon =
                          const Icon(Icons.check, color: ThemeColors.white);
                      buttonFileSelected = true;
                    });
                  }
                },
                label: const Text(
                  'Subir el archivo',
                  style: TextStyle(fontSize: 20, color: ThemeColors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
