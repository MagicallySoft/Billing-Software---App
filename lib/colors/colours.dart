import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//colors
Color white = Colors.white;
Color black = Colors.black;
Color blue = Colors.blueAccent;
Color green = Colors.green;
Color white70 = Colors.white70;
Color grey = Colors.grey;
Color grey900 = Colors.grey[900]!;
Color white24 = Colors.white24;

//fonts
TextStyle lato({
  required Color color,
  required FontWeight fontWeight,
  required double fontSize,
}) {
  return GoogleFonts.lato(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
  );
}
