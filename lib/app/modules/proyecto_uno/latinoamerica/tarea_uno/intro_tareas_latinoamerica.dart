import 'package:flutter/material.dart';

import '../../../../../../commons/strings_latinoamerica.dart';
import '../../../../../../commons/styles.dart';
import '../../../widgets/custom_text_form_field.dart';

class IntroTareaLatinoamericaPage extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const IntroTareaLatinoamericaPage({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<IntroTareaLatinoamericaPage> createState() =>
      _IntroTareaLatinoamericaPageState();
}

class _IntroTareaLatinoamericaPageState
    extends State<IntroTareaLatinoamericaPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController get controller => widget.controller;
  FocusNode get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsLationamerica.titleQOnePageOneLatin,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsLationamerica.qOneLatin,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            focusNode: focusNode,
            hint: 'Respuesta',
            controller: controller,
            keyboardType: TextInputType.text,
            validatorVazio: 'Ingrese tuja respuesta correctamente',
            validatorMenorqueNumero:
                'Su respuesta debe tener al menos 3 caracteres',
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
