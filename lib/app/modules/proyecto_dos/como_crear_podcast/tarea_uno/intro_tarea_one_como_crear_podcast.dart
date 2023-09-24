import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/custom_audio_player.dart';

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
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const CustomAudioPlayer(
            audioPath: 'assets/audios/teste.mp3',
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            StringsComoCrearUnPodcast.questionTareaUnoEscucharPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
