import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static TextStyle largeTextStyle = GoogleFonts.raleway(
    fontSize: 18,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
    color: Colors.black,
  );
  static TextStyle mediumTextStyle = GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: Colors.black,
  );
  static TextStyle smallTextStyle = GoogleFonts.raleway(
    fontSize: 14,
    color: Colors.black,
    letterSpacing: 1.5,
  );

  static TextStyle largeTitleStyle = GoogleFonts.raleway(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
    color: Colors.black,
  );
  static TextStyle mediumTitleStyle = GoogleFonts.raleway(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: Colors.black,
  );
  static TextStyle smallTitleStyle = GoogleFonts.raleway(
    fontSize: 20,
    color: Colors.black,
    letterSpacing: 1.5,
  );
}
