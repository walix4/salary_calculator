import 'package:flutter/material.dart';

/// Klarna-inspired colour tokens. Sampled from the reference screenshots.
class AppColors {
  AppColors._();

  // Brand
  static const Color pink = Color(0xFFFFB3C7);
  static const Color pinkStrong = Color(0xFFFF4D8D);
  static const Color pinkSoft = Color(0xFFFFE8EF);
  static const Color purple = Color(0xFF6A3FE0);
  static const Color purpleSoft = Color(0xFFEFEAFD);
  static const Color lavenderBanner = Color(0xFFE6DEFF);

  // Ink (near-black navy used for text and primary buttons)
  static const Color ink = Color(0xFF0B0626);
  static const Color textPrimary = Color(0xFF171717);
  static const Color textSecondary = Color(0xFF6B6A75);
  static const Color textTertiary = Color(0xFF9C9AA5);
  static const Color onInk = Color(0xFFFFFFFF);

  // Surfaces
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F7);
  static const Color surfaceStrong = Color(0xFFEEEEF2);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE8E8EC);
  static const Color borderStrong = Color(0xFFCFCED6);
  static const Color disabled = Color(0xFFD9D8DE);

  // Lavender header gradient (home hero)
  static const Color lavender = Color(0xFFD6D7F6);
  static const Color lavenderLight = Color(0xFFEDEAFB);

  // Status
  static const Color success = Color(0xFF0E7A3B);
  static const Color successSoft = Color(0xFFDCF8DF);
  static const Color toastSuccess = Color(0xFFA8F0B8);
  static const Color error = Color(0xFFD12C2C);
  static const Color errorSoft = Color(0xFFFDE7E7);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lavender, lavenderLight, background],
    stops: [0, 0.6, 1],
  );
}
