import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyectemos/commons/styles.dart';

void showToast(
  String text, {
  bool shortToast = true,
  bool fromBottom = true,
  Color color = ThemeColors.green,
  Color textColor = Colors.white,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: shortToast ? Toast.LENGTH_SHORT : Toast.LENGTH_SHORT,
    gravity: fromBottom ? ToastGravity.BOTTOM : ToastGravity.TOP,
    backgroundColor: color,
    textColor: textColor,
    fontSize: ScreenUtil().setSp(16),
  );
}
