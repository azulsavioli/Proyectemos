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
      padding: const EdgeInsets.all(8),
      child: RadioGroup<String>(
        groupValue: answer,
        onChanged: (value) {
          if (value == null) return;
          setState(() {
            answer = value;
            widget.onSelected(value);
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile<String>(
              activeColor: ThemeColors.yellow,
              fillColor: WidgetStateProperty.resolveWith(
                (states) => ThemeColors.blue,
              ),
              title: Text(widget.firstChoise),
              value: widget.firstChoise,
            ),
            RadioListTile<String>(
              fillColor: WidgetStateProperty.resolveWith(
                (states) => ThemeColors.blue,
              ),
              activeColor: ThemeColors.yellow,
              title: Text(widget.secondChoise),
              value: widget.secondChoise,
            ),
          ],
        ),
      ),
    );
  }
}
