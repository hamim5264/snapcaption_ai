import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/controllers/loading_controller.dart';
import 'glass.dart';

class AiLoadingOverlay extends StatelessWidget {
  const AiLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoadingController());

    return Container(
      color: Colors.black.withValues(alpha: 0.35),
      child: Center(
        child: Glass(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 42,
                height: 42,
                child: CircularProgressIndicator(strokeWidth: 2.6),
              ),
              const SizedBox(height: 18),

              Obx(
                () => Text(
                  c.currentMessage.value,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),

              Obx(
                () => Text(
                  "Estimated time: ~${c.etaSeconds.value}s",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
