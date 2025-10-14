import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/screens/home_screen.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentPageIndex = 0;

  final ThemeController _themeController = Get.find<ThemeController>();

  final List<Widget> _pages = const [
    HomeScreen(),
    Center(child: Text('My Course')),
    Center(child: Text('AI Assistant')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TopRoundCornerScreen(
        child: IndexedStack(index: _currentPageIndex, children: _pages),
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Skill Orbit',
        style: GoogleFonts.varelaRound(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Obx(() {
          return IconButton(
            onPressed: () => _themeController.changeTheme(),
            icon: Icon(
              _themeController.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Obx(() {
      final isDarkMode = _themeController.isDarkMode.value;
      return NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() => _currentPageIndex = index);
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.book), label: 'My Course'),
          NavigationDestination(
            icon: Icon(Icons.rocket_launch),
            label: 'AI Assistant',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      );
    });
  }
}
