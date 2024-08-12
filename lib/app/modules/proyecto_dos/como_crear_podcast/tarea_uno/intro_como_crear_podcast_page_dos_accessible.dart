import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

class IntroTareaComoCrearPodcastPageDosAccessible extends StatefulWidget {
  const IntroTareaComoCrearPodcastPageDosAccessible({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaComoCrearPodcastPageDosAccessible> createState() =>
      _IntroTareaComoCrearPodcastPageDosAccessibleState();
}

class _IntroTareaComoCrearPodcastPageDosAccessibleState
    extends State<IntroTareaComoCrearPodcastPageDosAccessible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.passoUnotitulo,
            style: ThemeText.paragraph16GrayBold,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsComoCrearUnPodcast.passoUnoDescricion,
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
