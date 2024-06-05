import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/player.dart';

class IntroTareaUnoComoCrearPodcastPage extends StatefulWidget {
  const IntroTareaUnoComoCrearPodcastPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaUnoComoCrearPodcastPage> createState() =>
      _IntroTareaUnoComoCrearPodcastPageState();
}

class _IntroTareaUnoComoCrearPodcastPageState
    extends State<IntroTareaUnoComoCrearPodcastPage> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player
          .setSource(AssetSource('audios/proyecto2.mp3', mimeType: 'mp3'));
      await player.resume();
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.questionTareaUnoEscucharPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          PlayerWidget(player: player),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
