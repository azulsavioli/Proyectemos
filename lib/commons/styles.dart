import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle title20White = TextStyle(
      fontSize: 20,
      letterSpacing: 1,
      fontFamily: 'Poppins',
      color: ThemeColors.white,
      fontWeight: FontWeight.bold);

  static const TextStyle paragraph16Blue = TextStyle(
      fontSize: 16,
      letterSpacing: 1,
      fontFamily: 'Poppins',
      color: ThemeColors.blue,
      fontWeight: FontWeight.bold);

  static const TextStyle paragraph14Blue = TextStyle(
      fontSize: 16,
      letterSpacing: 1,
      fontFamily: 'Poppins',
      color: ThemeColors.blue,
      fontWeight: FontWeight.bold);
}

abstract class ThemeColors {
  static const Color white = Color.fromRGBO(250, 251, 250, 1);
  static const Color blue = Color.fromRGBO(0, 159, 251, 1);
  static const Color red = Color.fromRGBO(243, 1, 70, 1);
  static const Color yellow = Color.fromRGBO(254, 147, 28, 1);
}
