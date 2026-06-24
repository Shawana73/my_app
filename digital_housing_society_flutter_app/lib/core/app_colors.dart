import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primaryPurple = Color(0xFF7C4DFF);
  static const secondaryPurple = Color(0xFFA970FF);
  static const deepPurple = Color(0xFF5B2EEA);
  static const lavender = Color(0xFFC9B6FF);
  static const lightPurple = Color(0xFFEDE7FF);
  static const background = Color(0xFFF7F7FC);
  static const card = Color(0xFFFFFFFF);
  static const primaryText = Color(0xFF1F2937);
  static const secondaryText = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
  static const hintText = Color(0xFF9CA3AF);
  static const successGreen = Color(0xFF22C55E);
  static const errorRed = Color(0xFFEF4444);
  static const warningOrange = Color(0xFFF59E0B);
  static const shadow = Color(0xFFD8CCFF);

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryPurple, secondaryPurple],
  );
}
