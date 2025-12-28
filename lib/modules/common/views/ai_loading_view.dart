import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_theme.dart';
import '../../home/widgets/glass.dart';
import '../controllers/loading_controller.dart';

class AiLoadingView extends StatelessWidget {
  const AiLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoadingController());

    return Container(
      decoration: AppTheme.backgroundGradient(),
      child: Center(
        child: Glass(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(strokeWidth: 2.6),
              const SizedBox(height: 22),

              Obx(
                () => Text(
                  c.currentMessage.value,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 10),

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
