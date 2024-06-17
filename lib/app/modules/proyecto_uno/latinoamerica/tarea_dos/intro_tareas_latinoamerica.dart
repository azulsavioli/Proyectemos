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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return Padding(
      padding: isMobile ? EdgeInsets.all(24) : EdgeInsets.all(34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: isMobile ? 20 : 30,
          ),
          Text(
            StringsLationamerica.titleQOnePageDosLatin,
            style: isMobile ? ThemeText.paragraph16GrayNormal : ThemeText.paragraph14Gray,
          ),
        ],
      ),
    );
  }
}
