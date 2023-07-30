import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings_artistas_latinoamericanos.dart';
import '../../../widgets/custom_record_audio_button.dart';
import '../artistas_controller.dart';

class QuestionArtistashispanoamericanosThree extends StatefulWidget {
  final ArtistasLatinoamericanosController controller;

  const QuestionArtistashispanoamericanosThree({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionArtistashispanoamericanosThree> createState() =>
      _QuestionArtistashispanoamericanosThreeState();
}

class _QuestionArtistashispanoamericanosThreeState
    extends State<QuestionArtistashispanoamericanosThree> {
  ArtistasLatinoamericanosController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsArtistasLationamerica.qThreeArtistasLatinPageOne,
            style: ThemeText.paragraph16GrayNormal,
          ),
          CustomRecordAudioButton(
            question: StringsArtistasLationamerica.qThreeArtistasLatinPageOne,
            isAudioFinish: controller.isAudioFinish,
            namedRoute: '/record_and_play',
            labelButton: 'Grabar la respuesta',
            labelButtonFinished: 'Completo',
          ),
        ],
      ),
    );
  }
}
