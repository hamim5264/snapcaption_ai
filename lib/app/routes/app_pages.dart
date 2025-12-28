import 'package:get/get.dart';

import '../../modules/onboarding/views/onboarding_screen.dart';
import '../../modules/api_key/views/api_key_screen.dart';
import '../../modules/home/views/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: Routes.apiKey, page: () => const ApiKeyScreen()),
    GetPage(name: Routes.home, page: () => const HomeScreen()),
  ];
}
