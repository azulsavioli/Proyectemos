import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

class IntroTareaComoCrearPodcastPageSeisAccessible extends StatefulWidget {
  const IntroTareaComoCrearPodcastPageSeisAccessible({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaComoCrearPodcastPageSeisAccessible> createState() =>
      _IntroTareaComoCrearPodcastPageSeisAccessibleState();
}

class _IntroTareaComoCrearPodcastPageSeisAccessibleState
    extends State<IntroTareaComoCrearPodcastPageSeisAccessible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.passoCincoTitulo,
            style: ThemeText.paragraph16GrayBold,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsComoCrearUnPodcast.passoCincoDescricion,
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
