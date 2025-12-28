import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass.dart';

class LoadingOverlay extends StatelessWidget {
  final String text;

  const LoadingOverlay({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withValues(alpha: 0.35)),
          ),
        ),
        Center(
          child: Glass(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Dots(),
                const SizedBox(height: 14),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Dots extends StatefulWidget {
  @override
  State<_Dots> createState() => _DotsState();
}

class _DotsState extends State<_Dots> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, _) {
        final t = _c.value;
        double s(int i) {
          final phase = (t * 3 - i).abs();
          final v = (1.0 - phase).clamp(0.0, 1.0);
          return 0.85 + (v * 0.55);
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: 10 * s(i),
              height: 10 * s(i),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
