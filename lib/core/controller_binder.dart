import 'package:get/get.dart';
import 'package:skillorbit/controllers/auth_controller.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/controllers/dashboard_controller.dart';
import 'package:skillorbit/controllers/home_screen_controller.dart';
import 'package:skillorbit/controllers/theme_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<CourseController>(CourseController(), permanent: true);
    Get.lazyPut<DashBoardController>(() => DashBoardController(), fenix: true);
    Get.lazyPut<HomeScreenController>(
      () => HomeScreenController(),
      fenix: true,
    );
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }
}
