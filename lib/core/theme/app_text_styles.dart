import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';


class AppTextStyles {
  AppTextStyles._();

  static TextStyle inter(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color color = Colors.black,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle get heading => inter(32, weight: FontWeight.w800, height: 1.15);
  static TextStyle get subtitle => inter(15, color: AppColors.subtitle);
  static TextStyle get body => inter(15, color: AppColors.hint);
}
