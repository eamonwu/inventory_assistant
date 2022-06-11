import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  // fontFamily: 'OpenSans',
);

final kLabelStyle = GoogleFonts.acme().copyWith(
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white.withOpacity(0.33),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
