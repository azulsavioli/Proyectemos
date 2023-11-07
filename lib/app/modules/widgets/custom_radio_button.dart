import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class CustomRadioButton extends StatefulWidget {
  final Function(String) onSelected;
  final String firstChoise;
  final String secondChoise;

  const CustomRadioButton({
    required this.onSelected,
    super.key,
    required this.firstChoise,
    required this.secondChoise,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String? answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: RadioListTile(
              activeColor: ThemeColors.yellow,
              title: Text(widget.firstChoise),
              value: widget.firstChoise,
              groupValue: answer,
              onChanged: (value) {
                setState(() {
                  answer = value.toString();
                  widget.onSelected(answer!);
                });
              },
            ),
          ),
          Expanded(
            child: RadioListTile(
              activeColor: ThemeColors.yellow,
              title: Text(widget.secondChoise),
              value: widget.secondChoise,
              groupValue: answer,
              onChanged: (value) {
                setState(() {
                  answer = value.toString();
                  widget.onSelected(answer!);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
