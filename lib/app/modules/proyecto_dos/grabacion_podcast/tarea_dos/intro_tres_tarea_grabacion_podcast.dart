import 'package:flutter/material.dart';

import '../../../../../../commons/styles.dart';
import '../../../../../commons/strings/strings_grabacion_podcast.dart';

class IntroTresTareaDosGrabacionPodcastPage extends StatefulWidget {
  const IntroTresTareaDosGrabacionPodcastPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTresTareaDosGrabacionPodcastPage> createState() =>
      _IntroTresTareaDosGrabacionPodcastPageState();
}

class _IntroTresTareaDosGrabacionPodcastPageState
    extends State<IntroTresTareaDosGrabacionPodcastPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsGrabacionPodcast.descriptionThreeTareaDosGrabacionPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsGrabacionPodcast.descriptionFourTareaDosGrabacionPodcast,
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
