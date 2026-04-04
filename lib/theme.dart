import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF776300);
  static const Color primaryContainer = Color(0xFFFDD400);
  static const Color onPrimaryContainer = Color(0xFF594A00);
  static const Color secondary = Color(0xFF006C90);
  static const Color secondaryContainer = Color(0xFF97DAFF);
  static const Color onSecondaryContainer = Color(0xFF004D68);
  static const Color tertiary = Color(0xFFC60159);
  static const Color tertiaryContainer = Color(0xFFFF8FA9);
  static const Color onTertiaryContainer = Color(0xFF66002B);
  static const Color surface = Color(0xFFFFFBFF);
  static const Color surfaceContainerLow = Color(0xFFFFFAE2);
  static const Color surfaceContainerHighest = Color(0xFFF4EB90);
  static const Color onSurface = Color(0xFF3D3905);
  static const Color onSurfaceVariant = Color(0xFF6B662E);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryContainer,
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        surface: surface,
        onSurface: onSurface,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w800,
          fontSize: 57,
          color: onSurface,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: onSurface,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: onSurface,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryContainer,
          foregroundColor: onPrimaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
