import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final String validatorVazio;
  final String validatorMenorque10;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.validatorVazio,
    required this.validatorMenorque10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            hint,
            style: ThemeText.paragraph16GrayLight,
          ),
        ),
      ),
      keyboardType: keyboardType,
      validator: (resposta) {
        {
          if (resposta!.isEmpty) {
            return validatorVazio;
          }
          if (resposta.length < 10) {
            return validatorMenorque10;
          }
          return null;
        }
      },
    );
  }
}
