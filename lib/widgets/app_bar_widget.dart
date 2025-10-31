import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillorbit/controllers/theme_controller.dart';

class AppBarWidget {
  static PreferredSizeWidget buildAppBar(ThemeController themeController) {
    return AppBar(
      elevation: 0,
      title: Row(
        spacing: 8,
        children: [
          const CircleAvatar(
            maxRadius: 17,
              foregroundImage: AssetImage("assets/logo/app_logo.png"),
          ),
          Text(
            'Skill Orbit',
            style: GoogleFonts.varelaRound(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      // Text(
      //   'Skill Orbit',
      //   style: GoogleFonts.varelaRound(
      //     fontSize: 28,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      actions: [
        Obx(() {
          return IconButton(
            onPressed: () => themeController.changeTheme(),
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          );
        }),
      ],
    );
  }
}
