import 'package:flutter/material.dart';
import 'package:skillorbit/screens/dashboard_screen.dart';
import 'package:skillorbit/screens/auth/login_screen.dart';
import 'package:skillorbit/screens/auth/signup_screen.dart';

class AppRoute {
  static Widget goToDashboardScreen() {
    return DashboardScreen();
  }

  static Widget goToLoginScreen() {
    return const LoginScreen();
  }

  static Widget goToSignupScreen() {
    return const SignupScreen();
  }
}
