import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_dos/conoces_podcast/tarea_uno/tarea_uno_controller.dart';

import '../../../../../commons/strings/strings_conoces_podcast.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_radio_button.dart';

class QuestionConocesPodcastDos extends StatefulWidget {
  final ConocesPodcastController controller;

  const QuestionConocesPodcastDos({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionConocesPodcastDos> createState() =>
      _QuestionConocesPodcastDosState();
}

class _QuestionConocesPodcastDosState extends State<QuestionConocesPodcastDos>
    with AutomaticKeepAliveClientMixin {
  ConocesPodcastController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsConocesPodcast.questionDosConocesPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomRadioButton(
            onSelected: (value) {
              _controller.answer2 = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
