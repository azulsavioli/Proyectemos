import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

showToast(String text,
    {bool shortToast = true,
    fromBottom = true,
    Color color = ThemeColors.blue,
    Color textColor = Colors.white}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: shortToast ? Toast.LENGTH_SHORT : Toast.LENGTH_SHORT,
      gravity: fromBottom ? ToastGravity.BOTTOM : ToastGravity.TOP,
      backgroundColor: color,
      textColor: textColor,
      fontSize: 16.0);
}
