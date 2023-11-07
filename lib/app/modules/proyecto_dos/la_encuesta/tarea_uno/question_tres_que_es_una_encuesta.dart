import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_dos/la_encuesta/tarea_uno/tarea_uno_controller.dart';
import 'package:proyectemos/app/modules/widgets/custom_record_audio_button.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../commons/styles.dart';

class QuestionQueEsUnaEncuestaTres extends StatefulWidget {
  final QueEsUnaEncuestaController controller;

  const QuestionQueEsUnaEncuestaTres({
    required this.controller,
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
              CustomRecordAudioButton(
                question: StringsLaEncuesta.questionThreeLaEncuestaTareaUno,
                isAudioFinish: _controller.isAudioFinish,
                namedRoute: '/record_and_play_la_encuesta_tarea_uno',
                labelButton: 'Grabar la respuesta',
                labelButtonFinished: 'Completo',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
