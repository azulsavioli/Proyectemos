import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';

class IntroTareaComoCrearPodcastPageCuatroAccessible extends StatefulWidget {
  const IntroTareaComoCrearPodcastPageCuatroAccessible({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaComoCrearPodcastPageCuatroAccessible> createState() =>
      _IntroTareaComoCrearPodcastPageCuatroAccessibleState();
}

class _IntroTareaComoCrearPodcastPageCuatroAccessibleState
    extends State<IntroTareaComoCrearPodcastPageCuatroAccessible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsComoCrearUnPodcast.passoTresTitulo,
            style: ThemeText.paragraph16GrayBold,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsComoCrearUnPodcast.passoTresDescricion,
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
