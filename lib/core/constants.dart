import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const String progressChannelKey = "Upload-Or-Download-Notification-Channel";
  static const Color primary  = Color(0xFFFF2156);
  static const Color secondary  = Color(0xFFffd3dd);

  static TextStyle largeTextStyle = GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
    color: Colors.black,
  );
  static TextStyle defaultTextStyle = GoogleFonts.raleway(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: Colors.black,
  );
  static TextStyle smallTextStyle = GoogleFonts.raleway(
    fontSize: 12,
    color: Colors.black,
    letterSpacing: 1.5,
  );

  static TextStyle largeTitleStyle = GoogleFonts.raleway(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
    color: Colors.black,
  );
  static TextStyle defaultTitleStyle = GoogleFonts.raleway(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: Colors.black,
  );
  static TextStyle smallTitleStyle = GoogleFonts.raleway(
    fontSize: 18,
    color: Colors.black,
    letterSpacing: 1.5,
  );
}
