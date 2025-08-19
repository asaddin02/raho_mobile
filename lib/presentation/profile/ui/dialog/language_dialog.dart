import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/profile/states/language/language_bloc.dart';

void showLanguageDialog(BuildContext context, ColorScheme colorScheme) {
  final l10n = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: 1.0,
          child: AlertDialog(
            backgroundColor: colorScheme.surface,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            ),
            title: Row(
              children: [
                Icon(Icons.language, color: const Color(0xFFE03A47), size: 24),
                const SizedBox(width: 8),
                Text(
                  l10n.languageDialogTitle,
                  style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (languageState is LanguageLoading)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFE03A47),
                      ),
                    ),
                  )
                else ...[
                  _buildLanguageOption(
                    context,
                    language: l10n.languageOptionIndonesian,
                    code: "id",
                    flag: "🇮🇩",
                    languageState: languageState,
                  ),
                  SizedBox(height: AppSizes.spacingSmall),
                  _buildLanguageOption(
                    context,
                    language: l10n.languageOptionEnglish,
                    code: "en",
                    flag: "🇺🇸",
                    languageState: languageState,
                  ),
                  SizedBox(height: AppSizes.spacingSmall),
                  _buildLanguageOption(
                    context,
                    language: l10n.languageOptionChinese,
                    code: "zh",
                    flag: "🇨🇳",
                    languageState: languageState,
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.languageCancelButton,
                  style: AppTextStyle.body.withColor(
                    colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildLanguageOption(
  BuildContext context, {
  required String language,
  required String code,
  required String flag,
  required LanguageState languageState,
}) {
  final languageBloc = context.read<LanguageBloc>();
  final isSelected = languageBloc.isLanguageSelected(code);
  final colorScheme = Theme.of(context).colorScheme;
  final l10n = AppLocalizations.of(context)!;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected
            ? const Color(0xFFE03A47)
            : colorScheme.outline.withValues(alpha: 0.2),
        width: isSelected ? 2 : 1,
      ),
      color: isSelected
          ? const Color(0xFFE03A47).withValues(alpha: 0.1)
          : Colors.transparent,
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: languageState is LanguageLoading
            ? null
            : () {
                if (!isSelected) {
                  languageBloc.add(ChangeLanguage(code));
                  Navigator.pop(context);

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Text(flag, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text(l10n.languageChangeSuccess(language)),
                        ],
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  language,
                  style: AppTextStyle.body.withColor(
                    isSelected
                        ? const Color(0xFFE03A47)
                        : colorScheme.onSurface,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFFE03A47),
                  size: 20,
                )
              else
                Icon(
                  Icons.circle_outlined,
                  color: colorScheme.outline.withValues(alpha: 0.5),
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
