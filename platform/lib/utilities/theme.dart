import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeDate {
  static final wTextStyle = GoogleFonts.acme();
  static final wWhiteTextStyle = GoogleFonts.acme().copyWith(
    color: Colors.white,
  );
  static final wTitleStyle = GoogleFonts.acme().copyWith(
    fontWeight: FontWeight.bold,
  );

  static final wWhiteTitleStyle = GoogleFonts.acme().copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final menuBackgroundColor = Color(0xff205e8d);
  // static final menuBackgroundColor = Color.fromARGB(255, 70, 195, 66);
  static final colors = {
    '简约蓝': Color(0xffddf0ff),
    "简约绿": Color(0xff4ae6b5),
    '简约橙': Color(0xfffaa381),
    '太空漫步': Color(0xff1b2cc1),
    '低调灰色': Color(0xffe1e6e1),
    '清爽夏日': Color(0xff45f0df),
    '祖绿': Color(0xff4fa485),
    '粉红少女心': Color(0xffff7b9c),
  };
  static MaterialColor getMaterialColor(String colorName) {
    int v = colors[colorName]!.value;
    return MaterialColor(
      v,
      <int, Color>{
        50: Color(v),
        100: Color(v),
        200: Color(v),
        300: Color(v),
        400: Color(v),
        500: Color(v),
        600: Color(v),
        700: Color(v),
        800: Color(v),
        900: Color(v),
      },
    );
  }
}
