import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_artistas_latinoamericanos.dart';
import '../../../widgets/custom_record_audio_button.dart';
import 'tarea_uno_controller.dart';

class QuestionArtistashispanoamericanosTwo extends StatefulWidget {
  final ArtistasLatinoamericanosTareaUnoController controller;

  const QuestionArtistashispanoamericanosTwo({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionArtistashispanoamericanosTwo> createState() =>
      _QuestionArtistashispanoamericanosTwoState();
}

class _QuestionArtistashispanoamericanosTwoState
    extends State<QuestionArtistashispanoamericanosTwo>
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
            StringsArtistasLationamerica.qTwoArtistasLatinPageOne,
            style: ThemeText.paragraph16GrayNormal,
          ),
          CustomRecordAudioButton(
            question: StringsArtistasLationamerica.qTwoArtistasLatinPageOne,
            isAudioFinish: controller.isAudioFinish,
            namedRoute: '/record_and_play',
            labelButton: 'Grabar la respuesta',
            labelButtonFinished: 'Completo',
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
