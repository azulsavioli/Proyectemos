import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_crea_tu_movimiento.dart';
import '../../../../../commons/styles.dart';

class IntroUnoCreaTuMovimientoTareaUno extends StatefulWidget {
  const IntroUnoCreaTuMovimientoTareaUno({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroUnoCreaTuMovimientoTareaUno> createState() =>
      _IntroUnoCreaTuMovimientoTareaUnoState();
}

class _IntroUnoCreaTuMovimientoTareaUnoState
    extends State<IntroUnoCreaTuMovimientoTareaUno> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsCreaTuMovimiento.descriptionUnoTareaUno,
            style: ThemeText.paragraph16GrayNormal,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            StringsCreaTuMovimiento.descriptionDosTareaUno,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
