
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_tres/la_sociedad/la_sociedade_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../commons/styles.dart';
import '../../../../commons/strings/strings.dart';
import '../../../../commons/strings/strings_la_sociedad.dart';
import '../../widgets/custom_record_audio_button.dart';

class QuestionLaSociedadTareaFour extends StatefulWidget {
  final LaSociedadController controller;

  const QuestionLaSociedadTareaFour({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionLaSociedadTareaFour> createState() =>
      _QuestionLaSociedadTareaFourState();
}

class _QuestionLaSociedadTareaFourState extends State<QuestionLaSociedadTareaFour> with AutomaticKeepAliveClientMixin {
  LaSociedadController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            StringsLaSociedad.discussionLaSociedad,
            style: ThemeText.paragraph16GrayNormal,
          ),
          CustomRecordAudioButton(
            question: StringsLaSociedad.discussionLaSociedad,
            isAudioFinish: controller.isAudioFinish,
            namedRoute: '/record_and_play_la_sociedad',
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


