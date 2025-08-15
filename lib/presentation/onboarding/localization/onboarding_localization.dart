import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/constants/app_assets.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/onboarding/model/onboarding_model.dart';

extension OnboardingLocalization on BuildContext {
  List<OnboardingModel> get localizedOnboardingItems {
    final l10n = AppLocalizations.of(this)!;

    return [
      OnboardingModel(
        image: AppAssets.onBoardingImage1,
        title: l10n.onboardingTitle1,
        description: l10n.onboardingSubtitle1,
      ),
      OnboardingModel(
        image: AppAssets.onBoardingImage2,
        title: l10n.onboardingTitle2,
        description: l10n.onboardingSubtitle2,
      ),
      OnboardingModel(
        image: AppAssets.onBoardingImage3,
        title: l10n.onboardingTitle3,
        description: l10n.onboardingSubtitle3,
      ),
    ];
  }
}
