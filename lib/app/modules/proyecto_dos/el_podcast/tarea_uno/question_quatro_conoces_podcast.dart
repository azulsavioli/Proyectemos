import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_dos/el_podcast/tarea_uno/tarea_uno_controller.dart';

import '../../../../../commons/strings/strings_conoces_podcast.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_record_audio_button.dart';

class QuestionConocesPodcastQuatro extends StatefulWidget {
  final ConocesPodcastController controller;

  const QuestionConocesPodcastQuatro({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionConocesPodcastQuatro> createState() =>
      _QuestionConocesPodcastQuatroState();
}

class _QuestionConocesPodcastQuatroState
    extends State<QuestionConocesPodcastQuatro>
    with AutomaticKeepAliveClientMixin {
  ConocesPodcastController get _controller => widget.controller;
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
            StringsConocesPodcast.questionQuatroConocesPodcast,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomRecordAudioButton(
            question: StringsConocesPodcast.questionQuatroConocesPodcast,
            isAudioFinish: _controller.isAudioFinish,
            namedRoute: '/record_and_play_conoces_podcast',
            labelButton: 'Grabar la respuesta',
            labelButtonFinished: 'Completo',
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
