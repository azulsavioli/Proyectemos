import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_evento_cultural.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_record_audio_button.dart';
import 'tarea_uno_controller.dart';

class TareaUnoEventoCulturalPage extends StatefulWidget {
  final EventoCulturalTareaUnoController controller;
  static List<PlatformFile> file = [];

  const TareaUnoEventoCulturalPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TareaUnoEventoCulturalPage> createState() =>
      _TareaUnoEventoCulturalPageState();
}

class _TareaUnoEventoCulturalPageState extends State<TareaUnoEventoCulturalPage>
    with AutomaticKeepAliveClientMixin {
  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy);
  Color buttonFileColor = ThemeColors.blue;

  bool buttonAudioSelected = false;
  Icon buttonAudioIcon = const Icon(Icons.record_voice_over);
  Color buttonAudioColor = ThemeColors.yellow;

  EventoCulturalTareaUnoController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
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
                    buttonFileIcon = const Icon(Icons.check);
                    buttonFileSelected = true;
                  });
                }
              },
              label: const Text(
                'Subir la propuesta escrita',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomRecordAudioButton(
            question: StringsEventoCultural.questionEventoCulturalAudio,
            isAudioFinish: _controller.isAudioFinish,
            namedRoute: '/record_and_play_propuesta',
            labelButton: 'Subir la propuesta oral',
            labelButtonFinished: 'Propuesta salva',
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
