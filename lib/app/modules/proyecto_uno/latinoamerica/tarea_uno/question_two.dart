import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../commons/styles.dart';
import '../../../../../commons/strings/strings_latinoamerica.dart';

class QuestionLatinoamericaTwo extends StatefulWidget {
  final YoutubePlayerController controller;
  final Function() listener;

  const QuestionLatinoamericaTwo({
    Key? key,
    required this.controller,
    required this.listener,
  }) : super(key: key);

  @override
  State<QuestionLatinoamericaTwo> createState() =>
      _QuestionLatinoamericaTwoState();
}

class _QuestionLatinoamericaTwoState extends State<QuestionLatinoamericaTwo> {
  YoutubePlayerController get controller => widget.controller;
  Function() get listener => widget.listener;

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return Padding(
      padding: isMobile ? EdgeInsets.all(24) : EdgeInsets.all(34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsLationamerica.titleQtwoPageOneLatin,
            style: isMobile
                ? ThemeText.paragraph16GrayNormal
                : ThemeText.paragraph14Gray,
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
