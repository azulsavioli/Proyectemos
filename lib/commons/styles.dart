import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ThemeText {
  // H1 Poppins
  static TextStyle h1title45WhiteBold = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h1title45RedBold = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h1title45BlueBold = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h1title45YellowBold = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.yellowOnWhite,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h1title45WhiteNormal = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h1title45RedNormal = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h1title45BlueNormal = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h1title45YellowNormal = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.yellowOnWhite,
    fontWeight: FontWeight.normal,
  );

  //H1 Ginto
  static TextStyle h1title45YellowBoldGinto = TextStyle(
    fontSize: ScreenUtil().setSp(45),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.yellowOnWhite,
    fontWeight: FontWeight.bold,
  );

  //H2
  static TextStyle h2title35White = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2title35Red = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2title35Blue = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2title35yellow = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.yellowOnWhite,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2title35WhiteNormal = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h2title35RedNormal = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h2title35BlueNormal = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h2title35yellowNormal = TextStyle(
    fontSize: ScreenUtil().setSp(35),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.yellowOnWhite,
    fontWeight: FontWeight.normal,
  );

  //H3
  static TextStyle h3title30White = TextStyle(
    fontSize: ScreenUtil().setSp(30),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3title20Red = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3title20Blue = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3title20Gray = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.gray,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3title20GrayNormal = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.gray,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h3title20yellow = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.yellowOnWhite,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3title20WhiteNormal = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h3title20RedNormal = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h3title20BlueNormal = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h3title20BlueBold = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3title20yellowNormal = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.yellowOnWhite,
    fontWeight: FontWeight.normal,
  );

  //Paragraph 16
  static TextStyle paragraph16RedBold = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph16BlueBold = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph16BlueNormal = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph16WhiteBold = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph16GrayBold = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.gray,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph16GrayNormal = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.gray,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph16GrayLight = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.grayLight,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph16White = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph14Blue = TextStyle(
    fontSize: ScreenUtil().setSp(16),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.normal,
  );

  //Paragraph 14

  static TextStyle paragraph14Gray = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.gray,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph14GrayBold = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.gray,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph14White = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph14WhiteBold = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph12Red = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph12RedBold = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.red,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph12Blue = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph12BlueBold = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph12White = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph12WhiteBold = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle paragraph12Gray = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.gray,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph8WhiteNormal = TextStyle(
    fontSize: ScreenUtil().setSp(8),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.normal,
  );

  static TextStyle paragraph6WhiteBold = TextStyle(
    fontSize: ScreenUtil().setSp(6),
    letterSpacing: 1,
    fontFamily: 'Poppins',
    color: ThemeColors.white,
    fontWeight: FontWeight.bold,
  );
}

abstract class ThemeColors {
  static const Color white = Color.fromRGBO(250, 251, 250, 1);

  /// Light brand hues. Illustration assets keep these tones; bars, titles
  /// and buttons use the darker family colors below so white text meets
  /// WCAG AA (4.5:1).
  static const Color blueLight = Color(0xFF009FFB);
  static const Color greenLight = Color(0xFF2AAF02);
  static const Color redLight = Color(0xFFF30146);

  static const Color blue = Color(0xFF01579B);
  static const Color green = Color(0xFF1B5E20);
  static const Color otherGreen = Color(0xFF4BB543);
  static const Color red = Color(0xFFB00040);
  static const Color yellow = Color.fromRGBO(254, 147, 28, 1);

  /// Darker amber for yellow-family text on [white]. About 6:1.
  static const Color yellowOnWhite = Color(0xFF9A4A00);

  /// Login gradient stops. White text is at least 4.8:1 on the lightest.
  static const Color loginBlueTop = Color(0xFF0277BD);
  static const Color loginBlueMid = Color(0xFF01579B);
  static const Color loginBlueBottom = Color(0xFF014A82);
  static const Color nearBlack = Color(0xFF1A1A1A);
  static const Color gray = Color(0xFF424242);
  static const Color grayLight = Color(0xFF616161);

  static double contrastRatio(Color foreground, Color background) {
    final foregroundLuminance = foreground.computeLuminance();
    final backgroundLuminance = background.computeLuminance();
    final lighter = math.max(foregroundLuminance, backgroundLuminance);
    final darker = math.min(foregroundLuminance, backgroundLuminance);
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Picks near-black or white, whichever is readable on [background].
  static Color foregroundOn(Color background) {
    final onDark = contrastRatio(nearBlack, background);
    final onLight = contrastRatio(white, background);
    return onDark >= onLight ? nearBlack : white;
  }
}

/// Theme used by the app and by screenshot captures, so buttons are not
/// Material 3's default purple.
ThemeData appTheme() {
  return ThemeData(
    primaryColor: ThemeColors.blue,
    secondaryHeaderColor: ThemeColors.yellow,
    scaffoldBackgroundColor: ThemeColors.white,
    colorScheme: const ColorScheme.light(
      primary: ThemeColors.blue,
      onPrimary: ThemeColors.white,
      secondary: ThemeColors.yellow,
      onSecondary: ThemeColors.nearBlack,
      error: ThemeColors.red,
      onError: ThemeColors.white,
      surface: ThemeColors.white,
      onSurface: ThemeColors.nearBlack,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.blue,
      foregroundColor: ThemeColors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: ThemeColors.white),
    ),
  );
}
