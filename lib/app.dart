import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/core/app_theme.dart';
import 'package:skillorbit/core/controller_binder.dart';
import 'package:skillorbit/screens/splash_screen.dart';

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
        home: const SplashScreen(), // Start with splash screen
      ),
    );
  }
}
