import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_latinoamerica.dart';
import '../../../../../commons/styles.dart';

class IntroTareaUnoLatinoamericaPage extends StatefulWidget {
  const IntroTareaUnoLatinoamericaPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaUnoLatinoamericaPage> createState() =>
      _IntroTareaUnoLatinoamericaPageState();
}

class _IntroTareaUnoLatinoamericaPageState
    extends State<IntroTareaUnoLatinoamericaPage> {
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
            StringsLationamerica.titleQOnePageDosLatin,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
