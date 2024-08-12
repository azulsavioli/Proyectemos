import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

class IntroTareaComoCrearPodcastPageSieteAccessible extends StatefulWidget {
  const IntroTareaComoCrearPodcastPageSieteAccessible({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaComoCrearPodcastPageSieteAccessible> createState() =>
      _IntroTareaComoCrearPodcastPageSieteAccessibleState();
}

class _IntroTareaComoCrearPodcastPageSieteAccessibleState
    extends State<IntroTareaComoCrearPodcastPageSieteAccessible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.passoSeisTitulo,
            style: ThemeText.paragraph16GrayBold,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsComoCrearUnPodcast.passoSeisDescricion,
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
