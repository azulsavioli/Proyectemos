import 'package:flutter/material.dart';

import '../../../../../commons/strings_evento_cultural.dart';
import '../../../../../commons/styles.dart';

class IntroTareaDosEventoCulturalPage extends StatefulWidget {
  const IntroTareaDosEventoCulturalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaDosEventoCulturalPage> createState() =>
      _IntroTareaDosEventoCulturalPageState();
}

class _IntroTareaDosEventoCulturalPageState
    extends State<IntroTareaDosEventoCulturalPage> {
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
            StringsEventoCultural.descriptionTwoEventocultural,
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
