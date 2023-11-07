import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_creacion_encuesta.dart';

import '../../../../../commons/styles.dart';
import 'tarea_uno_controller.dart';

class TareaCreacionEncuestaPage extends StatefulWidget {
  final CreacionEncuestaController controller;

  const TareaCreacionEncuestaPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TareaCreacionEncuestaPage> createState() =>
      _TareaCreacionEncuestaPageState();
}

class _TareaCreacionEncuestaPageState extends State<TareaCreacionEncuestaPage>
    with AutomaticKeepAliveClientMixin {
  CreacionEncuestaController get _controller => widget.controller;

  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy);
  Color buttonFileColor = ThemeColors.blue;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsCreacionEncuesta.descriptionOneTareaCreacionEncuesta,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    buttonFileIcon = const Icon(Icons.check);
                    buttonFileSelected = true;
                  });
                }
              },
              label: const Text(
                'Subir la encuesta',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            StringsCreacionEncuesta.descriptiontwoTareaCreacionEncuesta,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
