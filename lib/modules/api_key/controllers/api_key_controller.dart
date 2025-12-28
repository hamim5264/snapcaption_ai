import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/storage/local_storage.dart';
import '../../../app/routes/app_routes.dart';

class ApiKeyController extends GetxController {
  final keyCtrl = TextEditingController();
  final hasKey = false.obs;

  @override
  void onInit() {
    super.onInit();
    final saved = LocalStorage.userApiKey;
    if (saved != null && saved.isNotEmpty) {
      keyCtrl.text = saved;
      hasKey.value = true;
    }
  }

  Future<void> saveOrSkip({required bool save}) async {
    if (!save) {
      await LocalStorage.setUserApiKey(null);
      Get.offAllNamed(Routes.home);
      return;
    }

    final k = keyCtrl.text.trim();
    if (k.isEmpty || !k.startsWith('sk-')) {
      Get.snackbar(
        "Invalid key",
        "Please paste a valid OpenAI key (starts with sk-).",
      );
      return;
    }

    await LocalStorage.setUserApiKey(k);
    Get.offAllNamed(Routes.home);
  }
}
