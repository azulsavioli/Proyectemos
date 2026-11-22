import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../commons/styles.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';

class IntroTareaComoCrearUnaEncuestaPageimport extends StatefulWidget {
  final YoutubePlayerController controller;
  final Function() listener;

  const IntroTareaComoCrearUnaEncuestaPageimport({
    Key? key,
    required this.controller,
    required this.listener,
  }) : super(key: key);

  @override
  State<IntroTareaComoCrearUnaEncuestaPageimport> createState() =>
      _IntroTareaComoCrearUnaEncuestaPageimportState();
}

class _IntroTareaComoCrearUnaEncuestaPageimportState
    extends State<IntroTareaComoCrearUnaEncuestaPageimport> {
  YoutubePlayerController get controller => widget.controller;
  Function() get listener => widget.listener;

  Future<void> _launchURL() async {
    const url = 'https://www.youtube.com/watch?v=HVk3UYTKCr0';
    final uri = Uri.parse(url);
    var opened = false;
    try {
      if (await canLaunchUrl(uri)) {
        opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      opened = false;
    }
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el enlace de subtítulos.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsLaEncuesta.descriptionLaEncuestaTareaDos,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(height: 40),
          YoutubePlayer(
            thumbnail: const Text(
              'https://www.youtube.com/watch?v=HVk3UYTKCr0',
            ),
            controller: controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: ThemeColors.yellow,
            onReady: () {
              controller.addListener(listener);
            },
            bottomActions: [
              const SizedBox(width: 10),
              Flexible(child: CurrentPosition()),
              const SizedBox(width: 10),
              Expanded(
                flex: 6,
                child: ProgressBar(
                  colors: const ProgressBarColors(
                    playedColor: ThemeColors.yellow,
                    handleColor: ThemeColors.yellow,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(child: RemainingDuration()),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(ThemeColors.blue),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              icon: Icon(Icons.link, color: Colors.white),
              label: Text(
                "Ver con subtítulos en YouTube",
                style: ThemeText.paragraph14White,
              ),
              onPressed: _launchURL,
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
