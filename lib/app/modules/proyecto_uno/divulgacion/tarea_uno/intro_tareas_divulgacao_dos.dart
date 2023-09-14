import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_divulgacao.dart';
import '../../../../../commons/styles.dart';

class IntroTareaDosDivulgacaoPage extends StatefulWidget {
  const IntroTareaDosDivulgacaoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaDosDivulgacaoPage> createState() =>
      _IntroTareaDosDivulgacaoPageState();
}

class _IntroTareaDosDivulgacaoPageState
    extends State<IntroTareaDosDivulgacaoPage> {
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
            StringsDivulgacao.descricaoDivulgacaoCompartir,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
