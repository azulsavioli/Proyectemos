import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/custom_radio_button.dart';
import 'controller_dos_como_crear_podcast.dart';

class QuestionFourComoCrearPodcast extends StatefulWidget {
  final ControllerCrearUnPodcast controller;

  const QuestionFourComoCrearPodcast({
    super.key,
    required this.controller,
  });

  @override
  State<QuestionFourComoCrearPodcast> createState() =>
      _QuestionFourComoCrearPodcastState();
}

class _QuestionFourComoCrearPodcastState
    extends State<QuestionFourComoCrearPodcast>
    with AutomaticKeepAliveClientMixin {
  ControllerCrearUnPodcast get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            StringsComoCrearUnPodcast.questionFourTareaDosCrearUnPodcast,
            style: ThemeText.paragraph14Gray,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomRadioButton(
            firstChoise: 'entrevista',
            secondChoise: 'charla\nentre los miembros',
            onSelected: (value) {
              _controller.estructuraPodcast = value;
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
