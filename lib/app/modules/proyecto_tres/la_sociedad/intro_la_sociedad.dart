import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_la_sociedad.dart';

import '../../../../../commons/styles.dart';

class IntroLaSociedadPage extends StatefulWidget {
  const IntroLaSociedadPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroLaSociedadPage> createState() => _IntroLaSociedadPageState();
}

class _IntroLaSociedadPageState extends State<IntroLaSociedadPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsLaSociedad.descripcionTareaUnoQueEsLaSociedad,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
