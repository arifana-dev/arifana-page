import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.label,
    required this.title,
    this.subtitle,
    this.centered = false,
    super.key,
  });

  final String label;
  final String title;
  final String? subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final align =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 2,
              color: AppColors.primary,
            ),
            const SizedBox(width: 10),
            Text(
              label.toUpperCase(),
              style: AppTextStyles.sectionLabel,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: textAlign,
          style: AppTextStyles.headlineLarge,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ],
    );
  }
}
