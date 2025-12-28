import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../home/widgets/glass.dart';
import '../controllers/api_key_controller.dart';

class ApiKeyScreen extends StatelessWidget {
  const ApiKeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ApiKeyController());

    return Container(
      decoration: AppTheme.backgroundGradient(),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),

                      Glass(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Optional: Your OpenAI Key",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Skip to use default API (10 generations/day). "
                              "Add your own key for unlimited usage.",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.78),
                                  ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: c.keyCtrl,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "sk-xxxxxxxxxxxxxxxx",
                                filled: true,
                                fillColor: Colors.white.withValues(alpha: 0.08),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: Glass(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => c.saveOrSkip(save: false),
                                child: const Center(child: Text("Skip")),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () => c.saveOrSkip(save: true),
                                child: const Text("Save Key"),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
