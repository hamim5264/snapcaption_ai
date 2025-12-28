import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page.dart';
import '../../home/widgets/glass.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(OnboardingController());

    final pages = const [
      OnboardingPage(
        image: "assets/images/1.png",
        title: "SnapCaption AI",
        subtitle:
            "Turn travel moments into captions that feel human, stylish, and ready to post.",
      ),
      OnboardingPage(
        image: "assets/images/2.png",
        title: "Pick Photos",
        subtitle:
            "Select multiple photos from gallery or capture from camera — we’ll craft a story vibe.",
      ),
      OnboardingPage(
        image: "assets/images/3.png",
        title: "Copy & Post",
        subtitle:
            "Get title, description, and hashtags. Copy with one tap and post instantly.",
      ),
    ];

    final pageController = PageController();

    return Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (i) => c.pageIndex.value = i,
          children: pages,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Glass(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: c.skip,
                    child: Text(
                      "Skip",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Obx(() {
                  final idx = c.pageIndex.value;
                  return Glass(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Text("${idx + 1}/3"),
                  );
                }),
              ],
            ),
          ),
        ),
        Positioned(
          left: 18,
          right: 18,
          bottom: 22,
          child: Glass(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    final idx = c.pageIndex.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        final active = i == idx;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          height: 8,
                          width: active ? 26 : 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: active ? 0.85 : 0.35,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        );
                      }),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      final idx = c.pageIndex.value;
                      if (idx < 2) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOut,
                        );
                      } else {
                        c.next();
                      }
                    },
                    child: const Text("Next"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
