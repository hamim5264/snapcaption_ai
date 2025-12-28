import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../api_key/views/api_key_screen.dart';
import '../controllers/home_controller.dart';
import '../widgets/glass.dart';
import '../widgets/ai_loading_overlay.dart';
import '../widgets/result_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());
    c.ensureDailyCounter();

    return Container(
      decoration: AppTheme.backgroundGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("SnapCaption AI"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_rounded),
              onPressed: () => _showApiHelpDialog(context, c),
            ),
          ],
        ),

        body: Obx(
          () => Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _TopStats(c: c),
                  const SizedBox(height: 14),
                  _Pickers(c: c),
                  const SizedBox(height: 14),
                  _Controls(c: c),
                  const SizedBox(height: 14),
                  _GenerateButton(c: c),
                  const SizedBox(height: 18),
                  if (c.resultTitle.isNotEmpty)
                    ResultCard(
                      title: c.resultTitle.value,
                      description: c.resultDesc.value,
                      hashtags: c.resultTags,
                    ),
                  const SizedBox(height: 28),
                ],
              ),

              if (c.loading.value) const AiLoadingOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  void _showApiHelpDialog(BuildContext context, HomeController c) {
    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Glass(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.key_rounded),
                    const SizedBox(width: 8),
                    Text(
                      "API Key Information",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  "Current usage:",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),

                Text(
                  c.usingUserKey
                      ? "Using your own OpenAI API key (Unlimited usage)"
                      : "Using default API key (10 generations per day)",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "How to add your own OpenAI API key:",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                _guideStep("Visit https://platform.openai.com"),
                _guideStep("Open the API Keys section"),
                _guideStep("Create a new secret key"),
                _guideStep("Paste the key in the app API Key screen"),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Glass(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.offAll(() => const ApiKeyScreen());
                          },
                          child: const Center(
                            child: Text(
                              "Manage API Key",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Glass(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: Get.back,
                          child: const Center(
                            child: Text(
                              "Close",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierColor: Colors.black.withValues(alpha: 0.45),
    );
  }

  Widget _guideStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "• $text",
        style: TextStyle(color: Colors.white.withValues(alpha: 0.75)),
      ),
    );
  }
}

class _TopStats extends StatelessWidget {
  final HomeController c;

  const _TopStats({required this.c});

  @override
  Widget build(BuildContext context) {
    return Glass(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              c.usingUserKey
                  ? "Using your key • Unlimited ✨"
                  : "Using default key • Remaining today: ${c.remainingFree}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
          Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ],
      ),
    );
  }
}

class _Pickers extends StatelessWidget {
  final HomeController c;

  const _Pickers({required this.c});

  @override
  Widget build(BuildContext context) {
    return Glass(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Photos", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: c.pickFromGalleryMulti,
                  icon: const Icon(Icons.photo_library_rounded),
                  label: const Text("Gallery"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: c.pickFromCamera,
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: const Text("Camera"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Obx(() {
            if (c.images.isEmpty) {
              return Text(
                "No photos selected yet.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              );
            }

            return SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: c.images.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final f = c.images[i];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        Image.file(
                          File(f.path),
                          width: 92,
                          height: 92,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text("${i + 1}"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final HomeController c;

  const _Controls({required this.c});

  @override
  Widget build(BuildContext context) {
    return Glass(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generate Settings",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          Obx(
            () => Row(
              children: [
                _Chip(
                  label: "Instagram",
                  active: c.platform.value == 'instagram',
                  onTap: () => c.platform.value = 'instagram',
                ),
                const SizedBox(width: 8),
                _Chip(
                  label: "LinkedIn",
                  active: c.platform.value == 'linkedin',
                  onTap: () => c.platform.value = 'linkedin',
                ),
                const SizedBox(width: 8),
                _Chip(
                  label: "Product",
                  active: c.platform.value == 'product',
                  onTap: () => c.platform.value = 'product',
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Obx(
            () => Row(
              children: [
                _Chip(
                  label: "Fun",
                  active: c.tone.value == 'fun',
                  onTap: () => c.tone.value = 'fun',
                ),
                const SizedBox(width: 8),
                _Chip(
                  label: "Professional",
                  active: c.tone.value == 'professional',
                  onTap: () => c.tone.value = 'professional',
                ),
                const SizedBox(width: 8),
                _Chip(
                  label: "Poetic",
                  active: c.tone.value == 'poetic',
                  onTap: () => c.tone.value = 'poetic',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            onChanged: (v) => c.contextText.value = v,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  "Add travel context: beach sunset, mountains, hiking, city night…",
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.08),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenerateButton extends StatelessWidget {
  final HomeController c;

  const _GenerateButton({required this.c});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: c.generate,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome_rounded, size: 22),
            const SizedBox(width: 8),
            Text(
              "Generate Caption",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _Chip({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: active ? 0.18 : 0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: Colors.white.withValues(alpha: active ? 0.28 : 0.14),
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
