import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class CustomRadioButton extends StatefulWidget {
  final Function(String) onSelected;

  const CustomRadioButton({required this.onSelected, super.key});

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
              title: const Text('Si'),
              value: 'Si',
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
              title: const Text('No'),
              value: 'No',
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
