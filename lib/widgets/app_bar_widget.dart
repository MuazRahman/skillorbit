import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/controllers/auth_controller.dart';
import 'package:skillorbit/screens/auth/login_screen.dart';

class AppBarWidget {
  static PreferredSizeWidget buildAppBar(
    ThemeController themeController,
    BuildContext context,
  ) {
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
      actions: [
        IconButton(
          onPressed: () => _showSettingsDrawer(context, themeController),
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  static void _showSettingsDrawer(
    BuildContext context,
    ThemeController themeController,
  ) {
    final AuthController authController = Get.find<AuthController>();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Theme'),
                trailing: Obx(() {
                  return Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) {
                      themeController.changeTheme();
                    },
                  );
                }),
                onTap: () {
                  themeController.changeTheme();
                },
              ),
              const Divider(),
              // Show Login or Logout based on auth state
              Obx(() {
                final isLoggedIn = authController.isLoggedIn.value;
                return ListTile(
                  leading: Icon(isLoggedIn ? Icons.logout : Icons.login),
                  title: Text(isLoggedIn ? 'Logout' : 'Login'),
                  onTap: () async {
                    Get.back(); // Close the settings drawer
                    if (isLoggedIn) {
                      // User is logged in, sign them out
                      await authController.signOut();
                      Get.snackbar(
                        'Logged Out',
                        'You have been logged out successfully',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    } else {
                      // User is not logged in, navigate to login screen
                      Get.to(() => const LoginScreen());
                    }
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
