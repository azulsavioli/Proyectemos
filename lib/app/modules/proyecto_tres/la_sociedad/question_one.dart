
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_tres/la_sociedad/la_sociedade_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../commons/styles.dart';
import '../../../../../commons/strings/strings_latinoamerica.dart';
import '../../../../commons/strings/strings.dart';
import '../../../../commons/strings/strings_la_sociedad.dart';
import '../../widgets/custom_record_audio_button.dart';

class QuestionLaSociedadTareaUno extends StatefulWidget {
  final YoutubePlayerController youtubeController;
  final LaSociedadController controller;
  final Function() listener;

  const QuestionLaSociedadTareaUno({
    Key? key,
    required this.youtubeController,
    required this.controller,
    required this.listener,
  }) : super(key: key);

  @override
  State<QuestionLaSociedadTareaUno> createState() =>
      _QuestionLaSociedadTareaUnoState();
}

class _QuestionLaSociedadTareaUnoState extends State<QuestionLaSociedadTareaUno> with AutomaticKeepAliveClientMixin {
  YoutubePlayerController get youtubeController => widget.youtubeController;
  LaSociedadController get controller => widget.controller;
  Function() get listener => widget.listener;

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
          YoutubePlayer(
            thumbnail: const Text(
                'https://i.ytimg.com/vi/lcjK1P3kuGo/maxresdefault.jpg'),
            controller: youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: ThemeColors.yellow,
            onReady: () {
              controller.addListener(listener);
            },
            bottomActions: [
              const SizedBox(
                width: 10,
              ),
              Flexible(child: CurrentPosition()),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 6,
                child: ProgressBar(
                  colors: const ProgressBarColors(
                    playedColor: ThemeColors.yellow,
                    handleColor: ThemeColors.yellow,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(child: RemainingDuration()),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            StringsLaSociedad.questionLaSociedad,
            style: ThemeText.paragraph16GrayNormal,
          ),
          CustomRecordAudioButton(
            question: StringsLaSociedad.questionLaSociedad,
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


