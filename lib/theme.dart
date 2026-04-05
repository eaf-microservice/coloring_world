import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light theme colors
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

  // Dark theme colors (kid-friendly)
  static const Color darkPrimary = Color(0xFFFF6B9D);
  static const Color darkPrimaryContainer = Color(0xFFE84C7A);
  static const Color darkOnPrimaryContainer = Color(0xFFFFE0EC);
  static const Color darkSecondary = Color(0xFF64D5FF);
  static const Color darkSecondaryContainer = Color(0xFF0081B4);
  static const Color darkOnSecondaryContainer = Color(0xFFBEEDFF);
  static const Color darkTertiary = Color(0xFF9FFF59);
  static const Color darkTertiaryContainer = Color(0xFF7BC500);
  static const Color darkOnTertiaryContainer = Color(0xFFE1FFB2);
  static const Color darkSurface = Color(0xFF2A2233);
  static const Color darkOnSurface = Color(0xFFFFF8FB);
  static const Color darkOnSurfaceVariant = Color(0xFFE8C5DC);

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

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkPrimaryContainer,
        primary: darkPrimary,
        primaryContainer: darkPrimaryContainer,
        onPrimaryContainer: darkOnPrimaryContainer,
        secondary: darkSecondary,
        secondaryContainer: darkSecondaryContainer,
        onSecondaryContainer: darkOnSecondaryContainer,
        tertiary: darkTertiary,
        tertiaryContainer: darkTertiaryContainer,
        onTertiaryContainer: darkOnTertiaryContainer,
        surface: darkSurface,
        onSurface: darkOnSurface,
        brightness: Brightness.dark,
      ),
      textTheme:
          GoogleFonts.plusJakartaSansTextTheme(
            ThemeData(brightness: Brightness.dark).textTheme,
          ).copyWith(
            displayLarge: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w800,
              fontSize: 57,
              color: darkOnSurface,
            ),
            headlineSmall: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: darkOnSurface,
            ),
            labelLarge: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: darkOnSurface,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryContainer,
          foregroundColor: darkOnPrimaryContainer,
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
