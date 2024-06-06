import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_tu_alrededor.dart';

import '../../../../../../commons/styles.dart';
import '../../../widgets/custom_record_audio_button.dart';
import 'tu_alrededor_controller.dart';

class QuestionTuAlrededorFour extends StatefulWidget {
  final TuAlrededorController controller;

  const QuestionTuAlrededorFour({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionTuAlrededorFour> createState() =>
      _QuestionTuAlrededorFourState();
}

class _QuestionTuAlrededorFourState extends State<QuestionTuAlrededorFour>
    with AutomaticKeepAliveClientMixin {
  TuAlrededorController get controller => widget.controller;

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
            StringsTuAlrededor.qCuatroTuAlrededor,
            style: ThemeText.paragraph16GrayNormal,
          ),
          CustomRecordAudioButton(
            question: StringsTuAlrededor.qCuatroTuAlrededor,
            isAudioFinish: controller.isAudioFinish,
            namedRoute: '/record_and_play_tu_alrededor',
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
