import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  // LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColor.lightPrimary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFDBEAFE), // Blue 100
      secondary: AppColor.lightSecondary,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFDCFCE7), // Green 100
      tertiary: AppColor.accent,
      surface: AppColor.lightSurface,
      onSurface: AppColor.textPrimary,
      error: AppColor.error,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColor.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: AppColor.lightSurface,
      elevation: 0,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColor.grey200, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.lightPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.grey50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.grey300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.lightPrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColor.lightPrimary.withOpacity(0.12),
      backgroundColor: AppColor.lightSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      labelTextStyle: const WidgetStatePropertyAll(
        TextStyle(color: AppColor.textPrimary, fontSize: 12, fontWeight: FontWeight.w500),
      ),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: AppColor.textSecondary),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColor.grey200,
      thickness: 1,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // DARK THEME
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColor.darkPrimary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF1E3A5F),
      secondary: AppColor.darkSecondary,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF14532D),
      tertiary: AppColor.accent,
      surface: AppColor.darkSurface,
      onSurface: Color(0xFFE2E8F0), // Slate 200
      error: Color(0xFFF87171), // Red 400
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColor.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkSurface,
      foregroundColor: Color(0xFFE2E8F0),
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: AppColor.darkSurface,
      elevation: 0,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColor.grey700, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.darkPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.grey800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.grey600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.grey600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.darkPrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColor.darkPrimary.withOpacity(0.2),
      backgroundColor: AppColor.darkSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      labelTextStyle: const WidgetStatePropertyAll(
        TextStyle(color: Color(0xFFE2E8F0), fontSize: 12, fontWeight: FontWeight.w500),
      ),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: Color(0xFF94A3B8)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColor.grey700,
      thickness: 1,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
