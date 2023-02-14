import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class CustomRecordAudioButton extends StatefulWidget {
  final String question;
  final bool isAudioFinish;
  final String namedRoute;
  final String labelButton;
  final String labelButtonFinished;

  const CustomRecordAudioButton({
    super.key,
    required this.question,
    required this.isAudioFinish,
    required this.namedRoute,
    required this.labelButton,
    required this.labelButtonFinished,
  });

  @override
  State<CustomRecordAudioButton> createState() =>
      _CustomRecordAudioButtonState();
}

class _CustomRecordAudioButtonState extends State<CustomRecordAudioButton> {
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    final isAudioFinish = widget.isAudioFinish;
    return Column(
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
                _isButtonDisabled ? ThemeColors.green : ThemeColors.blue,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            icon: Icon(
              _isButtonDisabled ? Icons.check : Icons.mic,
              color: ThemeColors.white,
            ),
            label: Text(
              _isButtonDisabled
                  ? widget.labelButtonFinished
                  : widget.labelButton,
              style: const TextStyle(
                fontSize: 20,
                color: ThemeColors.white,
              ),
            ),
            onPressed: _isButtonDisabled
                ? null
                : () {
                    Navigator.pushNamed(
                      context,
                      widget.namedRoute,
                      arguments: widget.question,
                    );
                    Timer(
                      const Duration(milliseconds: 400),
                      () {
                        setState(
                          () {
                            if (isAudioFinish) {
                              _isButtonDisabled = false;
                            } else {
                              _isButtonDisabled = true;
                            }
                          },
                        );
                      },
                    );
                  },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
