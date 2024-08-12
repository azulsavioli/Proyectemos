import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

class IntroTareaComoCrearPodcastPageCincoAccessible extends StatefulWidget {
  const IntroTareaComoCrearPodcastPageCincoAccessible({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaComoCrearPodcastPageCincoAccessible> createState() =>
      _IntroTareaComoCrearPodcastPageCincoAccessibleState();
}

class _IntroTareaComoCrearPodcastPageCincoAccessibleState
    extends State<IntroTareaComoCrearPodcastPageCincoAccessible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.passoCuatroTitulo,
            style: ThemeText.paragraph16GrayBold,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsComoCrearUnPodcast.passoCuatroDescricion,
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
