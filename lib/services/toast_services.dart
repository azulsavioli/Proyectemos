import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proyectemos/commons/styles.dart';

void showToast(
  BuildContext context,
  String text,
  Color backgroundColor,
  Color textColor, {
  bool shortToast = true,
  bool fromBottom = true,
}) {
  final readableText =
      ThemeColors.contrastRatio(textColor, backgroundColor) >= 4.5
      ? textColor
      : ThemeColors.foregroundOn(backgroundColor);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 16.sp, color: readableText),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: shortToast ? 2 : 4),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: fromBottom
          ? EdgeInsets.only(bottom: 20, left: 20, right: 20)
          : EdgeInsets.only(top: 20, left: 20, right: 20),
    ),
  );
}
