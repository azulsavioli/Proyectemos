import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_movimientos_sociales.dart';
import '../../../../../commons/styles.dart';

class IntroTresMovimientosSocialesPage extends StatefulWidget {
  const IntroTresMovimientosSocialesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTresMovimientosSocialesPage> createState() =>
      _IntroTresMovimientosSocialesPageState();
}

class _IntroTresMovimientosSocialesPageState
    extends State<IntroTresMovimientosSocialesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              StringsMovimientosSociales.descriptionDos,
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.mode_edit_outlined,
                    color: ThemeColors.blue,
                  ),
                  title: Text(StringsMovimientosSociales.topicOne),
                ),
                ListTile(
                  leading: Icon(
                    Icons.emoji_objects_outlined,
                    color: ThemeColors.yellow,
                  ),
                  title: Text(StringsMovimientosSociales.topicTwo),
                ),
                ListTile(
                  leading: Icon(
                    Icons.local_play_outlined,
                    color: ThemeColors.red,
                  ),
                  title: Text(StringsMovimientosSociales.topicThree),
                ),
                ListTile(
                  leading: Icon(
                    Icons.movie_filter_outlined,
                    color: ThemeColors.green,
                  ),
                  title: Text(StringsMovimientosSociales.topicFour),
                ),
                ListTile(
                  leading: Icon(
                    Icons.subtitles_outlined,
                    color: ThemeColors.blue,
                  ),
                  title: Text(StringsMovimientosSociales.topicFive),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
