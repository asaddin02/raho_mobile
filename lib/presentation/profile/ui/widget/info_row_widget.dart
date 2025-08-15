import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.body.withColor(
            colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(value, style: AppTextStyle.body.withColor(colorScheme.onSurface)),
      ],
    );
  }
}
