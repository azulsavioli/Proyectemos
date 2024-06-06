import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_movimientos_sociales.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/player.dart';

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
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    player = AudioPlayer();

    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('audios/proyecto3.mp3'));
      await player.resume();
    });
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            PlayerWidget(player: player),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
