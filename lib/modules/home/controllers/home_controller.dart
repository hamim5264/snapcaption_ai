import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/constants/app_constants.dart';
import '../../../data/services/api_service.dart';
import '../../../data/storage/local_storage.dart';

class HomeController extends GetxController {
  final _picker = ImagePicker();

  final images = <XFile>[].obs;

  final platform = 'instagram'.obs;
  final tone = 'fun'.obs;

  final contextText = ''.obs;

  final resultTitle = ''.obs;
  final resultDesc = ''.obs;
  final resultTags = <String>[].obs;

  final loading = false.obs;

  bool get usingUserKey => (LocalStorage.userApiKey?.isNotEmpty ?? false);

  Future<void> ensureDailyCounter() async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (LocalStorage.dailyDate != today) {
      await LocalStorage.resetDay(today);
    }
  }

  int get remainingFree {
    final used = LocalStorage.dailyCount;
    return (AppConstants.dailyFreeLimit - used).clamp(
      0,
      AppConstants.dailyFreeLimit,
    );
  }

  Future<void> pickFromGalleryMulti() async {
    final files = await _picker.pickMultiImage(imageQuality: 85);
    if (files.isEmpty) return;
    images.assignAll(files);
  }

  Future<void> pickFromCamera() async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (file == null) return;
    images.add(file);
  }

  void clear() {
    images.clear();
    resultTitle.value = '';
    resultDesc.value = '';
    resultTags.clear();
  }

  Future<void> generate() async {
    await ensureDailyCounter();

    if (images.isEmpty) {
      Get.snackbar("No photos", "Please add at least one photo first.");
      return;
    }

    if (!usingUserKey && remainingFree <= 0) {
      Get.defaultDialog(
        title: "Daily limit reached",
        middleText:
            "You used ${AppConstants.dailyFreeLimit} generations today.\nAdd your own OpenAI key for unlimited usage.",
        textConfirm: "OK",
        onConfirm: Get.back,
      );
      return;
    }

    loading.value = true;

    try {
      final res = await ApiService.generateCaption(
        platform: platform.value,
        tone: tone.value,
        imageCount: images.length,
        context: contextText.value.trim(),
        userApiKey: LocalStorage.userApiKey,
        userTitle: '',
        userDescription: '',
      );

      resultTitle.value = (res['title'] ?? '').toString();
      resultDesc.value = (res['description'] ?? '').toString();

      final tags =
          (res['hashtags'] as List?)?.map((e) => e.toString()).toList() ?? [];
      resultTags.assignAll(tags);

      if (!usingUserKey) {
        await LocalStorage.incrementDailyCount();
      }

      Get.snackbar("Generated", "Caption ready");
    } catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: e.toString(),
        textConfirm: "OK",
        onConfirm: Get.back,
      );
    } finally {
      loading.value = false;
    }
  }

  File asFile(XFile f) => File(f.path);
}
