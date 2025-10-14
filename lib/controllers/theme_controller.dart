import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Observable boolean
  RxBool isDarkMode = false.obs;

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
