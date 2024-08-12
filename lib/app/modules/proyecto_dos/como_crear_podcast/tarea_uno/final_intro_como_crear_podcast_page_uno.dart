import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

class FinalIntroTareaComoCrearPodcastPageUnoAccessible extends StatefulWidget {
  const FinalIntroTareaComoCrearPodcastPageUnoAccessible({
    Key? key,
  }) : super(key: key);

  @override
  State<FinalIntroTareaComoCrearPodcastPageUnoAccessible> createState() =>
      _FinalIntroTareaComoCrearPodcastPageUnoAccessibleState();
}

class _FinalIntroTareaComoCrearPodcastPageUnoAccessibleState
    extends State<FinalIntroTareaComoCrearPodcastPageUnoAccessible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.encerramientoPodcast1,
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
