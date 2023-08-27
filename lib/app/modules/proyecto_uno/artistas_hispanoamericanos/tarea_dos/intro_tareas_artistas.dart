import 'package:flutter/material.dart';

import '../../../../../commons/strings.dart';
import '../../../../../commons/strings_artistas_latinoamericanos.dart';
import '../../../../../commons/styles.dart';

class IntroTareaDosArtistasHispanoamericanosPage extends StatefulWidget {
  const IntroTareaDosArtistasHispanoamericanosPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaDosArtistasHispanoamericanosPage> createState() =>
      _IntroTareaDosArtistasHispanoamericanosPageState();
}

class _IntroTareaDosArtistasHispanoamericanosPageState
    extends State<IntroTareaDosArtistasHispanoamericanosPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              Strings.titleArtistasHispanoamericanosDos,
              style: ThemeText.paragraph14Blue,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            textAlign: TextAlign.start,
            StringsArtistasLationamerica.titleQOnePageDosArtistasLatin,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
