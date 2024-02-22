import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final String validatorVazio;
  final String validatorMenorqueNumero;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.validatorVazio,
    required this.validatorMenorqueNumero,
    required this.focusNode,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textInputAction: textInputAction,
      autofocus: true,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ThemeColors.blue),
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 8),
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
          if (resposta.length < 3) {
            return validatorMenorqueNumero;
          }
          return null;
        }
      },
    );
  }
}
