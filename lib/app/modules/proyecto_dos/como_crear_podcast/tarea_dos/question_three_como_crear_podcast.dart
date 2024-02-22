import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';
import 'controller_dos_como_crear_podcast.dart';

class QuestionThreeComoCrearPodcast extends StatefulWidget {
  final ControllerCrearUnPodcast controller;

  const QuestionThreeComoCrearPodcast({
    super.key,
    required this.controller,
  });

  @override
  State<QuestionThreeComoCrearPodcast> createState() =>
      _QuestionThreeComoCrearPodcastState();
}

class _QuestionThreeComoCrearPodcastState
    extends State<QuestionThreeComoCrearPodcast>
    with AutomaticKeepAliveClientMixin {
  ControllerCrearUnPodcast get _controller => widget.controller;

  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(
    Icons.file_copy,
    color: ThemeColors.white,
  );
  Color buttonFileColor = ThemeColors.blue;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                StringsComoCrearUnPodcast.questionThreeTareaDosCrearUnPodcast,
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  icon: buttonFileIcon,
                  onPressed: () async {
                    final file = await _controller.selectFile();
                    if (file != null) {
                      setState(() {
                        buttonFileColor = ThemeColors.green;
                        buttonFileIcon = const Icon(
                          Icons.check,
                          color: ThemeColors.white,
                        );
                        buttonFileSelected = true;
                      });
                    }
                  },
                  label: const Text(
                    'Subir la identidad visual',
                    style: TextStyle(fontSize: 20, color: ThemeColors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
