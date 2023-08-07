import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../commons/strings_latinoamerica.dart';
import '../../../../../../commons/styles.dart';

class QuestionLatinoamericaOne extends StatefulWidget {
  final YoutubePlayerController controller;
  final Function() listener;

  const QuestionLatinoamericaOne({
    Key? key,
    required this.controller,
    required this.listener,
  }) : super(key: key);

  @override
  State<QuestionLatinoamericaOne> createState() =>
      _QuestionLatinoamericaOneState();
}

class _QuestionLatinoamericaOneState extends State<QuestionLatinoamericaOne> {
  YoutubePlayerController get controller => widget.controller;
  Function() get listener => widget.listener;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsLationamerica.titleQtwoPageOneLatin,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 40,
          ),
          YoutubePlayer(
            thumbnail: const Text(
              'https://img.youtube.com/vi/R21d66HYGPw/hqdefault.jpg',
            ),
            controller: controller,
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
        ],
      ),
    );
  }
}
