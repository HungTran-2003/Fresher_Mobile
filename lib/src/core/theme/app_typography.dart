import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const String fontFamilyRoboto = 'Roboto';
  static TextStyle _skeleton({
    required double fontSize,
    required FontWeight fontWeight,
    double? letterSpacing,
    Color? color,
  }) {
    return GoogleFonts.nunitoSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  // Headline Skeletons
  static TextStyle get headlineLarge =>
      _skeleton(fontSize: 30, fontWeight: FontWeight.w600);

  static TextStyle get headlineMedium =>
      _skeleton(fontSize: 28, fontWeight: FontWeight.w600);

  static TextStyle get headlineSmall =>
      _skeleton(fontSize: 24, fontWeight: FontWeight.w600);

  // Title Skeletons
  static TextStyle get titleLarge =>
      _skeleton(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle get titleMedium =>
      _skeleton(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get titleSmall =>
      _skeleton(fontSize: 14, fontWeight: FontWeight.w600);

  // Body Skeletons
  static TextStyle get bodyLarge =>
      _skeleton(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get bodyMedium =>
      _skeleton(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get bodySmall =>
      _skeleton(fontSize: 12, fontWeight: FontWeight.w600);

  static TextStyle get bodyTiny =>
      _skeleton(fontSize: 10, fontWeight: FontWeight.w500);

  static TextStyle get body16Bo =>
      _skeleton(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get body16Semi =>
      _skeleton(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get des12Re =>
      _skeleton(fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle get des12Semi =>
      _skeleton(fontSize: 12, fontWeight: FontWeight.w500);
}
