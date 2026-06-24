// lib/theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF7B4DFF);
  static const Color secondaryPurple = Color(0xFF9C6BFF);
  static const Color lightLavender = Color(0xFFF5F3FF);
  static const Color darkText = Color(0xFF1F1F39);
  static const Color greyText = Color(0xFF8E8EA9);
  static const Color whiteCard = Color(0xFFFFFFFF);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color rejected = Color(0xFFEF4444);

  static const double borderRadiusValue = 24.0;
  static final BorderRadius borderRadius = BorderRadius.circular(borderRadiusValue);

  static final List<BoxShadow> softShadows = [
    BoxShadow(
      color: primaryPurple.withOpacity(0.04),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.03),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: lightLavender,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        primary: primaryPurple,
        secondary: secondaryPurple,
        background: lightLavender,
        surface: whiteCard,
      ),
      fontFamily: 'Inter',
      cardTheme: CardThemeData(
        color: whiteCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkText),
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: darkText, fontSize: 32, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: darkText, fontSize: 16),
        bodyMedium: TextStyle(color: greyText, fontSize: 14),
      ),
    );
  }
}

