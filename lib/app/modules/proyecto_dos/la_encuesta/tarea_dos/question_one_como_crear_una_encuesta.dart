import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/providers/acessibility_provider.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../widgets/custom_record_audio_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'tarea_dos_controller.dart';

class QuestionComoCrearUnaEncuestaOne extends StatefulWidget {
  final TareaDosComoCrearUnaEncuestaController controller;
  final TextEditingController textController;
  final FocusNode focusNode;

  const QuestionComoCrearUnaEncuestaOne({
    Key? key,
    required this.controller,
    required this.textController,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<QuestionComoCrearUnaEncuestaOne> createState() =>
      _QuestionComoCrearUnaEncuestaOneState();
}

class _QuestionComoCrearUnaEncuestaOneState
    extends State<QuestionComoCrearUnaEncuestaOne> {
  TareaDosComoCrearUnaEncuestaController get _controller => widget.controller;
  TextEditingController get _textController => widget.textController;
  FocusNode get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();
    final isAccessibleOn =
        accessibility.loaded && accessibility.isEnabled(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsLaEncuesta.questionOneLaEncuestaTareaDos,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          if (isAccessibleOn)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextFormField(
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                hint: 'Respuesta',
                controller: _textController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tu respuesta correctamente',
                validatorMenorqueNumero:
                    'Su respuesta debe tener al menos 3 caracteres',
              ),
            )
          else
            CustomRecordAudioButton(
              question: StringsLaEncuesta.questionOneLaEncuestaTareaDos,
              isAudioFinish: _controller.isAudioFinish,
              namedRoute: '/record_and_play_la_encuesta_tarea_dos',
              labelButton: 'Grabar la respuesta',
              labelButtonFinished: 'Completo',
            ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
