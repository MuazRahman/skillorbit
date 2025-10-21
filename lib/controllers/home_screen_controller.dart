import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxDouble courseProgress = 80.5.obs; // 0–100 range

  void updateProgress(double value) {
    courseProgress.value = value.clamp(0, 100);
  }

}
