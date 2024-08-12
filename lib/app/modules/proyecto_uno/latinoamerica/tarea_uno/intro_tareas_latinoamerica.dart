import 'package:flutter/material.dart';

import '../../../../../../commons/styles.dart';
import '../../../../../commons/strings/strings_latinoamerica.dart';
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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    super.build(context);

    return Padding(
      padding: isMobile ? EdgeInsets.all(24) : EdgeInsets.all(34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsLationamerica.titleQOnePageOneLatin,
            style: isMobile
                ? ThemeText.paragraph16GrayNormal
                : ThemeText.paragraph14Gray,
          ),
          SizedBox(
            height: isMobile ? 20 : 30,
          ),
          Text(
            StringsLationamerica.qOneLatin,
            style: isMobile
                ? ThemeText.paragraph16GrayNormal
                : ThemeText.paragraph14Gray,
          ),
          SizedBox(
            height: isMobile ? 20 : 60,
          ),
          CustomTextFormField(
            focusNode: focusNode,
            textInputAction: TextInputAction.next,
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
