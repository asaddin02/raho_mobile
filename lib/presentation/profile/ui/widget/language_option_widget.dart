import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';

class LanguageOption extends StatelessWidget {
  final String language;
  final String code;
  final bool isSelected;

  const LanguageOption({
    super.key,
    required this.language,
    required this.code,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFE03A47).withValues(alpha: 0.1)
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: isSelected
              ? const Color(0xFFE03A47)
              : colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle language selection
          },
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingMedium),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? const Color(0xFFE03A47)
                      : colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 20,
                ),
                SizedBox(width: AppSizes.spacingSmall),
                Text(
                  language,
                  style: AppTextStyle.body.withColor(
                    isSelected
                        ? const Color(0xFFE03A47)
                        : colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
