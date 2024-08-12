import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_dos/la_encuesta/tarea_uno/tarea_uno_controller.dart';
import 'package:proyectemos/app/modules/widgets/custom_record_audio_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionQueEsUnaEncuestaTres extends StatefulWidget {
  final QueEsUnaEncuestaController controller;
  final TextEditingController textController;
  final FocusNode focusNode;

  const QuestionQueEsUnaEncuestaTres({
    required this.controller,
    required this.textController,
    required this.focusNode,
    super.key,
  });

  @override
  State<QuestionQueEsUnaEncuestaTres> createState() =>
      _QuestionQueEsUnaEncuestaTresState();
}

class _QuestionQueEsUnaEncuestaTresState
    extends State<QuestionQueEsUnaEncuestaTres>
    with AutomaticKeepAliveClientMixin {
  QueEsUnaEncuestaController get _controller => widget.controller;
  TextEditingController get _textController => widget.textController;
  FocusNode get focusNode => widget.focusNode;
  bool isAccessible = false;

  @override
  initState() {
    super.initState();
    getIsAcessible();
  }

  Future<void> getIsAcessible() async {
    final preferences = await SharedPreferences.getInstance();
    final isAccessibleOn = preferences.getBool("isAccessible");
    setState(() {
      if (isAccessibleOn != null) {
        isAccessible = isAccessibleOn;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                StringsLaEncuesta.questionThreeLaEncuestaTareaUno,
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              if (isAccessible)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: CustomTextFormField(
                    focusNode: focusNode,
                    textInputAction: TextInputAction.next,
                    hint: 'Respuesta',
                    controller: _textController,
                    keyboardType: TextInputType.text,
                    validatorVazio: 'Ingrese tuja respuesta correctamente',
                    validatorMenorqueNumero:
                        'Su respuesta debe tener al menos 3 caracteres',
                  ),
                )
              else
                CustomRecordAudioButton(
                  question: StringsLaEncuesta.questionThreeLaEncuestaTareaUno,
                  isAudioFinish: _controller.isAudioFinish,
                  namedRoute: '/record_and_play_la_encuesta_tarea_uno',
                  labelButton: 'Grabar la respuesta',
                  labelButtonFinished: 'Completo',
                )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
