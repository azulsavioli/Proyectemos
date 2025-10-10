import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showToast(
    BuildContext context,
    String text,
    Color backgroundColor,
    Color textColor, {
      bool shortToast = true,
      bool fromBottom = true,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: textColor,
        ),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: shortToast ? 2 : 4),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: fromBottom
          ? EdgeInsets.only(bottom: 20, left: 20, right: 20)
          : EdgeInsets.only(top: 20, left: 20, right: 20),
    ),
  );
}