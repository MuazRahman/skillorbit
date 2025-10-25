import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/dashboard_controller.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/screens/home_screen.dart';
import 'package:skillorbit/screens/my_course_screen.dart';
import 'package:skillorbit/screens/profile_screen.dart';
import 'package:skillorbit/widgets/app_bar_widget.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ThemeController _themeController = Get.find<ThemeController>();
  final DashBoardController _dashBoardController =
      Get.find<DashBoardController>();

  final List<Widget> pages = [
    const HomeScreen(),
    const MyCourseScreen(),
    Center(child: Text('AI Assistant')),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.buildAppBar(_themeController),
      body: TopRoundCornerScreen(
        child: Obx(
          () => IndexedStack(
            index: _dashBoardController.currentPageIndex.value,
            children: pages,
          ),
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Obx(() {
      return NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).colorScheme.primary.withAlpha(51),
        selectedIndex: _dashBoardController.currentPageIndex.value,
        onDestinationSelected: (index) {
          _dashBoardController.currentPageIndex.value = index;
          // setState(() => _currentPageIndex = index);
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
