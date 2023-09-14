import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_artistas_latinoamericanos.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/custom_record_audio_button.dart';
import 'tarea_uno_controller.dart';

class QuestionArtistashispanoamericanosOne extends StatefulWidget {
  final ArtistasLatinoamericanosTareaUnoController controller;

  const QuestionArtistashispanoamericanosOne({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionArtistashispanoamericanosOne> createState() =>
      _QuestionArtistashispanoamericanosOneState();
}

class _QuestionArtistashispanoamericanosOneState
    extends State<QuestionArtistashispanoamericanosOne>
    with AutomaticKeepAliveClientMixin {
  ArtistasLatinoamericanosTareaUnoController get controller =>
      widget.controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsArtistasLationamerica.qOneArtistasLatinPageOne,
            style: ThemeText.paragraph16GrayNormal,
          ),
          CustomRecordAudioButton(
            question: StringsArtistasLationamerica.qOneArtistasLatinPageOne,
            isAudioFinish: controller.isAudioFinish,
            namedRoute: '/record_and_play',
            labelButton: 'Grabar la respuesta',
            labelButtonFinished: 'Completo',
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
