import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageIndex = 0.obs;

  void next() {
    if (pageIndex.value < 2) {
      pageIndex.value++;
    } else {
      Get.offAllNamed(Routes.apiKey);
    }
  }

  void skip() => Get.offAllNamed(Routes.apiKey);
}
