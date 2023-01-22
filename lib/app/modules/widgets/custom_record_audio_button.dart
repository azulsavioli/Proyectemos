import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../providers/record_audio_provider.dart';

class CustomRecordAudioButton extends StatefulWidget {
  final String question;

  const CustomRecordAudioButton({
    super.key,
    required this.question,
  });

  @override
  State<CustomRecordAudioButton> createState() =>
      _CustomRecordAudioButtonState();
}

class _CustomRecordAudioButtonState extends State<CustomRecordAudioButton> {
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    final audioProvider =
        Provider.of<RecordAudioProvider>(context, listen: false);

    bool recordsDeleted = audioProvider.recordsDeleted;

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  _isButtonDisabled ? ThemeColors.green : ThemeColors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: () {
              _isButtonDisabled
                  ? null
                  : {
                      Navigator.pushNamed(context, '/record_and_play',
                          arguments: widget.question),
                      Timer(const Duration(milliseconds: 400), () {
                        setState(() {
                          if (recordsDeleted) {
                            _isButtonDisabled = false;
                          } else {
                            _isButtonDisabled = true;
                          }
                        });
                      })
                    };
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        _isButtonDisabled ? Icons.check : Icons.mic,
                        color: ThemeColors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _isButtonDisabled ? 'Completo' : 'Grabar la respuesta',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
