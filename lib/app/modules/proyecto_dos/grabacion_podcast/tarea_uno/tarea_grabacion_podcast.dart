import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_grabacion_podcast.dart';
import '../../../../../commons/styles.dart';
import 'tarea_uno_controller.dart';

class TareaUnoGrabacionPodcastPage extends StatefulWidget {
  final GrabacionPodcastController controller;

  const TareaUnoGrabacionPodcastPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TareaUnoGrabacionPodcastPage> createState() =>
      _TareaUnoGrabacionPodcastPageState();
}

class _TareaUnoGrabacionPodcastPageState
    extends State<TareaUnoGrabacionPodcastPage>
    with AutomaticKeepAliveClientMixin {
  GrabacionPodcastController get _controller => widget.controller;

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
            StringsGrabacionPodcast.descriptionThreeTareaUnoGrabacionPodcast,
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
                'Subir el archivo',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            StringsGrabacionPodcast.descriptionFourTareaUnoGrabacionPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
