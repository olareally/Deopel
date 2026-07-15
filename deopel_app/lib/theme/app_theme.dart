import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Deopel brand palette — derived from the company logo:
///  • Navy blue  (sun rays / inner gear)  → primary
///  • Crimson red (outer gear ring)        → accent / call-to-action
///  • Field green (wavy crop lines)        → success / highlight
class AppColors {
  AppColors._();

  // Navy family
  static const Color navy900 = Color(0xFF0E1A44);
  static const Color navy800 = Color(0xFF16245C);
  static const Color navy700 = Color(0xFF1B2A6B);
  static const Color navy600 = Color(0xFF25368A);
  static const Color navy050 = Color(0xFFEEF1FB);

  // Red family
  static const Color red600 = Color(0xFFED1C24);
  static const Color red700 = Color(0xFFC30F16);
  static const Color red050 = Color(0xFFFEF2F2);
  static const Color redSoft = Color(0xFFFF7A7A);

  // Green family
  static const Color green600 = Color(0xFF22B14C);
  static const Color green700 = Color(0xFF178A3A);
  static const Color green050 = Color(0xFFEDFBF1);

  // Neutrals
  static const Color ink = Color(0xFF0F172A);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color bgSoft = Color(0xFFF7F8FB);
  static const Color white = Color(0xFFFFFFFF);
}

/// Reusable layout constants.
class AppSizing {
  AppSizing._();

  static const double maxContentWidth = 1280;
  static const double radiusSm = 8;
  static const double radius = 16;
  static const double radiusLg = 24;

  static const double mobileBreakpoint = 720;
  static const double tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < tabletBreakpoint;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.navy700,
        primary: AppColors.navy700,
        secondary: AppColors.red600,
        tertiary: AppColors.green600,
        surface: AppColors.white,
      ),
    );

    final displayFont = GoogleFonts.montserrat;
    final bodyFont = GoogleFonts.inter;

    // Base every text style on Inter, then override headings with Montserrat
    // so the whole site shares one professional type system.
    final baseText = GoogleFonts.interTextTheme(base.textTheme)
        .apply(bodyColor: AppColors.slate700, displayColor: AppColors.navy900);

    return base.copyWith(
      textTheme: baseText.copyWith(
            displayLarge: displayFont(
              fontWeight: FontWeight.w800,
              height: 1.08,
              letterSpacing: -0.5,
              color: AppColors.navy900,
            ),
            displayMedium: displayFont(
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: -0.3,
              color: AppColors.navy900,
            ),
            headlineMedium: displayFont(
              fontWeight: FontWeight.w700,
              height: 1.18,
              letterSpacing: -0.2,
              color: AppColors.navy900,
            ),
            titleLarge: displayFont(
              fontWeight: FontWeight.w700,
              color: AppColors.navy900,
            ),
            titleMedium: displayFont(
              fontWeight: FontWeight.w600,
              color: AppColors.navy900,
            ),
            bodyLarge: bodyFont(
              fontSize: 17,
              height: 1.65,
              color: AppColors.slate700,
            ),
            bodyMedium: bodyFont(
              fontSize: 15.5,
              height: 1.6,
              color: AppColors.slate700,
            ),
            labelLarge: bodyFont(
              fontWeight: FontWeight.w600,
              color: AppColors.navy900,
            ),
          ),
    );
  }
}
