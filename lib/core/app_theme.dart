import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  // LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: AppColor.lightThemeColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.lightThemeColor,
      foregroundColor: Colors.black,
      elevation: 1,
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 3,
      margin: EdgeInsets.all(8),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColor.lightThemeColor.withOpacity(0.5),
      backgroundColor: Colors.white,
      labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.black87)),
      iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.black87)),
    ),
  );

  // DARK THEME
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.darkThemeColor,
      brightness: Brightness.dark,
      background: const Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF212121),
      foregroundColor: Colors.white,
      elevation: 1,
    ),
    cardTheme: const CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 2,
      margin: EdgeInsets.all(8),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColor.darkThemeColor.withOpacity(0.4),
      backgroundColor: const Color(0xFF1A1A1A),
      labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
      iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
    ),
  );
}
