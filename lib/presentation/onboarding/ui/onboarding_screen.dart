import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';

import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/onboarding/bloc/onboarding/onboarding_bloc.dart';
import 'package:raho_member_apps/presentation/onboarding/localization/onboarding_localization.dart';
import 'package:raho_member_apps/presentation/onboarding/model/onboarding_model.dart';
import 'package:raho_member_apps/presentation/onboarding/ui/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final onboardingItems = context.localizedOnboardingItems;
    return BlocProvider(
      create: (context) => OnboardingBloc(totalPages: onboardingItems.length),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state.isCompleted) {
            context.goNamed(AppRoutes.verification.name);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: AppGradientColor.gradientPrimary,
              ),
              child: SafeArea(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      _buildHeader(context, state, l10n, onboardingItems),
                      _buildPageView(context, state, onboardingItems),
                      _buildPageIndicator(context, state, onboardingItems),
                      _buildBottomButtons(context, state, l10n),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    OnboardingState state,
    AppLocalizations l10n,
    List<OnboardingModel> onboardingItems,
  ) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLarge,
          vertical: AppSizes.paddingMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMedium,
                vertical: AppSizes.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppColor.greyLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              ),
              child: Text(
                '${state.currentIndex + 1}/${onboardingItems.length}',
                style: AppTextStyle.caption.withColor(AppColor.greyMedium),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.greyLight.withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              ),
              child: TextButton(
                onPressed: () =>
                    context.read<OnboardingBloc>().add(OnboardingSkipped()),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingLarge,
                    vertical: AppSizes.paddingSmall,
                  ),
                ),
                child: Text(
                  l10n.buttonSkipOnboarding,
                  style: AppTextStyle.body.withColor(AppColor.greyMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView(
    BuildContext context,
    OnboardingState state,
    List<OnboardingModel> onboardingItems,
  ) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          context.read<OnboardingBloc>().add(
            OnboardingPageChanged(index: index),
          );
        },
        itemCount: onboardingItems.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
              }
              return Transform.scale(
                scale: Curves.easeOut.transform(value),
                child: child,
              );
            },
            child: OnboardingPage(
              item: onboardingItems[index],
              isActive: state.currentIndex == index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator(
    BuildContext context,
    OnboardingState state,
    List<OnboardingModel> onboardingItems,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onboardingItems.length,
          (index) => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            width: state.currentIndex == index ? 24 : 6,
            decoration: BoxDecoration(
              color: state.currentIndex == index
                  ? AppColor.primary
                  : AppColor.greyLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(
    BuildContext context,
    OnboardingState state,
    AppLocalizations l10n,
  ) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        child: Row(
          children: [
            if (state.currentIndex > 0)
              Expanded(
                flex: 1,
                child: Container(
                  height: 56,
                  margin: EdgeInsets.only(right: AppSizes.paddingSmall),
                  // Reduced margin
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.greyLight.withValues(alpha: 0.8),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  ),
                  child: TextButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(
                        OnboardingPreviousPage(),
                      );
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusLarge,
                        ),
                      ),
                    ),
                    child: Text(
                      l10n.buttonPreviousOnboarding,
                      style: AppTextStyle.body
                          .withWeight(AppFontWeight.medium)
                          .withColor(AppColor.greyMedium),
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: state.currentIndex > 0 ? 1 : 2,
              child: Container(
                height: 56,
                margin: state.currentIndex > 0
                    ? EdgeInsets.only(
                        left: AppSizes.paddingSmall,
                      ) // Reduced margin
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primary, AppColor.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (state.isLastPage) {
                      context.read<OnboardingBloc>().add(OnboardingCompleted());
                    } else {
                      context.read<OnboardingBloc>().add(OnboardingNextPage());
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    ),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.isLastPage
                              ? l10n.buttonCompleteOnboarding
                              : l10n.buttonNextOnboarding,
                          style: AppTextStyle.body
                              .withWeight(AppFontWeight.semiBold)
                              .withColor(AppColor.white),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          state.isLastPage
                              ? Icons.check_circle_outline
                              : Icons.arrow_forward,
                          color: AppColor.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
