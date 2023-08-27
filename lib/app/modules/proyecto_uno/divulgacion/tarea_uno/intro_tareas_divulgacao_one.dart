import 'package:flutter/material.dart';

import '../../../../../commons/strings_divulgacao.dart';
import '../../../../../commons/styles.dart';

class IntroTareaUnoDivulgacaoPage extends StatefulWidget {
  const IntroTareaUnoDivulgacaoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaUnoDivulgacaoPage> createState() =>
      _IntroTareaUnoDivulgacaoPageState();
}

class _IntroTareaUnoDivulgacaoPageState
    extends State<IntroTareaUnoDivulgacaoPage> {
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
            StringsDivulgacao.descricaoDivulgacaoTarea,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
