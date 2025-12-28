import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'glass.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> hashtags;

  const ResultCard({
    super.key,
    required this.title,
    required this.description,
    required this.hashtags,
  });

  Future<void> _copy(BuildContext context, String text, String label) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$label copied")));
  }

  @override
  Widget build(BuildContext context) {
    final tagsText = hashtags.join(' ');

    return Glass(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Row(label: "Title", onCopy: () => _copy(context, title, "Title")),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 14),
          _Row(
            label: "Description",
            onCopy: () => _copy(context, description, "Description"),
          ),
          Text(description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 14),
          _Row(
            label: "Hashtags",
            onCopy: () => _copy(context, tagsText, "Hashtags"),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: hashtags
                .map(
                  (h) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.14),
                      ),
                    ),
                    child: Text(h),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final VoidCallback onCopy;

  const _Row({required this.label, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onCopy,
          icon: Icon(
            Icons.copy_all_rounded,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
