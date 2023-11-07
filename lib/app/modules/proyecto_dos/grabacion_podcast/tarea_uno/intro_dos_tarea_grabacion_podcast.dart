import 'package:flutter/material.dart';
import '../../../../../commons/strings/strings_grabacion_podcast.dart';
import '../../../../../commons/styles.dart';

class IntroTareaDosGrabacionPodcastPage extends StatefulWidget {
  const IntroTareaDosGrabacionPodcastPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaDosGrabacionPodcastPage> createState() =>
      _IntroTareaDosGrabacionPodcastPageState();
}

class _IntroTareaDosGrabacionPodcastPageState
    extends State<IntroTareaDosGrabacionPodcastPage> {
  @override
  Widget build(BuildContext context) {
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
            StringsGrabacionPodcast.descriptionTwoTareaUnoGrabacionPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
