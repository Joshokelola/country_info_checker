import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false);

  void toggleTheme() {
    state = !state;
  }
}

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0B0F1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0B0F1E),
    elevation: 0,
  ),
  colorScheme: ColorScheme.dark(
    surface: const Color(0xFF0B0F1E),
    primaryContainer: Colors.white.withOpacity(0.08),
  ),
  cardTheme: CardTheme(
    color: Colors.white.withOpacity(0.08),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withOpacity(0.08),
    hintStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.5)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.inter(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.inter(
      color: Colors.white,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.inter(
      color: Colors.white70,
      fontSize: 14,
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.white.withOpacity(0.08),
    labelStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.9)),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  ),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF2B2B2B)),
    titleTextStyle: TextStyle(
      color: Color(0xFF2B2B2B),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2B2B2B),
    onPrimary: Colors.white,
    surface: Colors.white,
    background: Colors.white,
    onSurface: Color(0xFF2B2B2B),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF5F5F5),
    hintStyle: GoogleFonts.inter(
      color: const Color(0xFF2B2B2B).withOpacity(0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.inter(
      color: Color(0xFF2B2B2B),
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.inter(
      color: Color(0xFF2B2B2B),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.inter(
      color: Color(0xFF666666),
      fontSize: 14,
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFFF5F5F5),
    labelStyle: GoogleFonts.inter(
      color: Color(0xFF2B2B2B),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFFEEEEEE),
    thickness: 1,
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFF2B2B2B),
    size: 24,
  ),
);
