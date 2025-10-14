import 'package:flutter/material.dart';

class AppColor {
  // 🌞 LIGHT THEME COLORS
  static const Color lightThemeColor = Colors.green; // primary light theme color
  static const Color lightPrimary = Colors.green;
  static const Color lightPrimaryVariant = Colors.greenAccent;
  static const Color lightSecondary = Colors.teal;
  static const Color lightBackground = Colors.white;
  static const Color lightSurface = Colors.white;

  // 🌙 DARK THEME COLORS
  static const Color darkThemeColor = Colors.greenAccent; // primary dark theme color
  static const Color darkPrimary = Colors.greenAccent;
  static const Color darkPrimaryVariant = Colors.green;
  static const Color darkSecondary = Colors.tealAccent;
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  // ⚫ NEUTRAL
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // 🔴 STATUS COLORS
  static const Color error = Colors.redAccent;
  static const Color warning = Colors.orangeAccent;
  static const Color success = Colors.greenAccent;
  static const Color info = Colors.lightBlueAccent;
}
