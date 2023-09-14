import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

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
          const SizedBox(
            height: 20,
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
