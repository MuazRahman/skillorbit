import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/core/app_theme.dart';

class TopRoundCornerScreen extends StatelessWidget {
  final Widget? child;

  const TopRoundCornerScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;
      final scaffoldBackground = Theme.of(context).scaffoldBackgroundColor;

      // AppBar colors from AppTheme
      final Color? appBarColor = isDarkMode
          ? AppTheme.darkTheme.appBarTheme.backgroundColor
          : AppTheme.lightTheme.appBarTheme.backgroundColor;

      return DecoratedBox(
        decoration: BoxDecoration(
          color: appBarColor, // outer background (behind the curve)
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Container(
            color: scaffoldBackground, // actual page background
            child: child,
          ),
        ),
      );
    });
  }
}
