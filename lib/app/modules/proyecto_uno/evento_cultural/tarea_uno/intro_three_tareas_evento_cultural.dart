import 'package:flutter/material.dart';

import '../../../../../commons/strings_evento_cultural.dart';
import '../../../../../commons/styles.dart';

class IntroTareaTresEventoCulturalPage extends StatefulWidget {
  const IntroTareaTresEventoCulturalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaTresEventoCulturalPage> createState() =>
      _IntroTareaTresEventoCulturalPageState();
}

class _IntroTareaTresEventoCulturalPageState
    extends State<IntroTareaTresEventoCulturalPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsEventoCultural.descriptionThreeEventocultural,
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
