import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/storage/language_storage_service.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/presentation/profile/states/language/language_bloc.dart';

class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LanguageSelectionDialog(),
    );
  }

  static Future<void> showAndWait(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LanguageSelectionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingXl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  ),
                  child: Icon(
                    Icons.language_rounded,
                    size: 32,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(height: AppSizes.spacingMedium),
                // Title
                Text(
                  'Choose Language',
                  style: const TextStyle(fontSize: 20)
                      .withColor(AppColor.black)
                      .withWeight(AppFontWeight.semiBold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSizes.spacingSmall),
                Text(
                  'Select your preferred language',
                  style: const TextStyle(
                    fontSize: 14,
                  ).withColor(AppColor.grey).withWeight(AppFontWeight.regular),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSizes.spacingLarge),
                // Language Options
                _buildCompactLanguageOption(
                  context: context,
                  flag: '🇮🇩',
                  language: 'Bahasa Indonesia',
                  languageCode: 'id',
                ),
                SizedBox(height: AppSizes.spacingSmall),
                _buildCompactLanguageOption(
                  context: context,
                  flag: '🇺🇸',
                  language: 'English',
                  languageCode: 'en',
                ),
                SizedBox(height: AppSizes.spacingSmall),
                _buildCompactLanguageOption(
                  context: context,
                  flag: '🇨🇳',
                  language: '中文',
                  languageCode: 'zh',
                ),
                SizedBox(height: AppSizes.spacingLarge),
                // Skip Button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => _selectLanguage(context, 'en'),
                    // Default English when skip
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.paddingMedium,
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: const TextStyle(fontSize: 14)
                          .withColor(AppColor.grey)
                          .withWeight(AppFontWeight.medium),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactLanguageOption({
    required BuildContext context,
    required String flag,
    required String language,
    required String languageCode,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _selectLanguage(context, languageCode),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.paddingMedium,
            horizontal: AppSizes.paddingMedium,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            border: Border.all(
              color: AppColor.greyLight.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 20)),
              SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: Text(
                  language,
                  style: const TextStyle(
                    fontSize: 16,
                  ).withColor(AppColor.black).withWeight(AppFontWeight.medium),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColor.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode) {
    context.read<LanguageBloc>().add(ChangeLanguage(languageCode));
    LanguageService.markLanguageSelectionComplete();
    Navigator.of(context).pop();
  }
}
