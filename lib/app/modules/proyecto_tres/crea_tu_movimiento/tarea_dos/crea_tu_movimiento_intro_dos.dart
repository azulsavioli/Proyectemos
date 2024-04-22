import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_crea_tu_movimiento.dart';
import '../../../../../commons/styles.dart';

class IntroDosCreaTuMovimientoTareaUno extends StatefulWidget {
  const IntroDosCreaTuMovimientoTareaUno({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroDosCreaTuMovimientoTareaUno> createState() =>
      _IntroDosCreaTuMovimientoTareaUnoState();
}

class _IntroDosCreaTuMovimientoTareaUnoState
    extends State<IntroDosCreaTuMovimientoTareaUno> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsCreaTuMovimiento.titleDescriptionTareaDos,
            style: ThemeText.paragraph16GrayNormal,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            StringsCreaTuMovimiento.descriptionTareaDos,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
