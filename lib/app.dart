import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/core/app_theme.dart';
import 'package:skillorbit/core/controller_binder.dart';
import 'package:skillorbit/screens/splash_screen.dart';
import 'package:skillorbit/screens/auth/login_screen.dart';
import 'package:skillorbit/screens/auth/signup_screen.dart';
import 'package:skillorbit/screens/dashboard_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Skill Orbit',
        initialBinding: ControllerBinder(),
        theme: themeController.isDarkMode.value
            ? AppTheme.darkTheme
            : AppTheme.lightTheme,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignupScreen()),
          GetPage(name: '/dashboard', page: () => const DashboardScreen()),
        ],
      ),
    );
  }
}
