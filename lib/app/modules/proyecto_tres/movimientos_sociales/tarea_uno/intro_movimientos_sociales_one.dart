import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_movimientos_sociales.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/custom_audio_player.dart';

class IntroUnoMovimientosSocialesPage extends StatefulWidget {
  const IntroUnoMovimientosSocialesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroUnoMovimientosSocialesPage> createState() =>
      _IntroUnoMovimientosSocialesPageState();
}

class _IntroUnoMovimientosSocialesPageState
    extends State<IntroUnoMovimientosSocialesPage> {
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
          Text(
            StringsMovimientosSociales.descriptionUno,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomAudioPlayer(
            audioPath: 'assets/audios/proyecto2',
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
