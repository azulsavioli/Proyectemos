import 'package:flutter/material.dart';

/// Learning content stays in Spanish and is announced with a Spanish locale.
class SpanishText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const SpanishText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        locale: const Locale('es'),
        style: style,
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
