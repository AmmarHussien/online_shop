import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appstyle(
  double size,
  Color color,
  FontWeight fontWeight,
) {
  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle appstyleWithHeight(
  double size,
  Color color,
  FontWeight fontWeight,
  double height,
) {
  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
    height: height,
  );
}
