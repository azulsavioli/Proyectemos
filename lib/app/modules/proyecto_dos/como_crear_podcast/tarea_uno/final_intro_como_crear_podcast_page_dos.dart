import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

class FinalIntroTareaComoCrearPodcastPageDosAccessible extends StatefulWidget {
  const FinalIntroTareaComoCrearPodcastPageDosAccessible({
    Key? key,
  }) : super(key: key);

  @override
  State<FinalIntroTareaComoCrearPodcastPageDosAccessible> createState() =>
      _FinalIntroTareaComoCrearPodcastPageDosAccessibleState();
}

class _FinalIntroTareaComoCrearPodcastPageDosAccessibleState
    extends State<FinalIntroTareaComoCrearPodcastPageDosAccessible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.encerramientoPodcast2,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsComoCrearUnPodcast.encerramientoPodcast3,
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
