import 'dart:async';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  final messages = [
    "✨ Brewing the perfect caption...",
    "🎒 Packing words for your journey...",
    "🌄 Matching vibes with your photo...",
    "🧠 Thinking like a creator...",
    "📸 Turning moments into words...",
    "💡 Adding a creative spark...",
  ];

  final currentMessage = "".obs;
  final etaSeconds = 6.obs;

  Timer? _messageTimer;
  Timer? _etaTimer;
  int _index = 0;

  @override
  void onInit() {
    super.onInit();
    currentMessage.value = messages.first;
    _startRotation();
    _startEta();
  }

  void _startRotation() {
    _messageTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _index = (_index + 1) % messages.length;
      currentMessage.value = messages[_index];
    });
  }

  void _startEta() {
    _etaTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (etaSeconds.value > 1) {
        etaSeconds.value--;
      }
    });
  }

  @override
  void onClose() {
    _messageTimer?.cancel();
    _etaTimer?.cancel();
    super.onClose();
  }
}
