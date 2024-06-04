import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_evento_cultural.dart';
import '../../../../../commons/styles.dart';

class IntroTareaUnoEventoCulturalPage extends StatefulWidget {
  const IntroTareaUnoEventoCulturalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaUnoEventoCulturalPage> createState() =>
      _IntroTareaUnoEventoCulturalPageState();
}

class _IntroTareaUnoEventoCulturalPageState
    extends State<IntroTareaUnoEventoCulturalPage> {
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
            StringsEventoCultural.descriptionOneEventocultural,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
