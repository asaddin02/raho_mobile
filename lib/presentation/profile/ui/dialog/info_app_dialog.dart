import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/profile/ui/widget/info_row_widget.dart';

void showAppInfoDialog(BuildContext context, ColorScheme colorScheme) {
  String dateString = "2025-10-11";
  DateTime date = DateTime.parse(dateString);
  final l10n = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSizes.paddingSmall),
            decoration: BoxDecoration(
              color: const Color(0xFFE03A47).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: const Color(0xFFE03A47),
              size: 24,
            ),
          ),
          SizedBox(width: AppSizes.spacingSmall),
          Text(
            l10n.aboutDialogTitle,
            style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(label: l10n.aboutVersionLabel, value: l10n.appVersion),
          SizedBox(height: AppSizes.spacingSmall),
          InfoRow(label: l10n.aboutCopyrightLabel, value: l10n.companyClubName),
          SizedBox(height: AppSizes.spacingSmall),
          InfoRow(label: l10n.aboutReleaseDateLabel, value: formatDateLocal(date)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.aboutCloseButton,
            style: AppTextStyle.body.withColor(const Color(0xFFE03A47)),
          ),
        ),
      ],
    ),
  );
}
