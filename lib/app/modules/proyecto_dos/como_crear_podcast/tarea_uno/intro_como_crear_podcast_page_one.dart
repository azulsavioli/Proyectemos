import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/player.dart';
import '../../../widgets/spanish_text.dart';

class IntroTareaComoCrearPodcastPageUno extends StatefulWidget {
  const IntroTareaComoCrearPodcastPageUno({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaComoCrearPodcastPageUno> createState() =>
      _IntroTareaComoCrearPodcastPageUnoState();
}

class _IntroTareaComoCrearPodcastPageUnoState
    extends State<IntroTareaComoCrearPodcastPageUno> {
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.introTareaUnoEscucharPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          PlayerWidget(player: player),
          const SizedBox(height: 16),
          Text('Transcrição', style: ThemeText.paragraph16GrayBold),
          const SizedBox(height: 8),
          SpanishText(
            '${StringsComoCrearUnPodcast.apresentacionDelPodcast}\n${StringsComoCrearUnPodcast.passoUnotitulo}${StringsComoCrearUnPodcast.passoUnoDescricion}',
            style: ThemeText.paragraph14Gray,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
