import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/extensions.dart';
import 'package:raho_member_apps/presentation/onboarding/model/onboarding_model.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingModel item;
  final bool isActive;

  const OnboardingPage({super.key, required this.item, required this.isActive});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _imageFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _textController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _imageScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.elasticOut),
    );

    _imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textSlideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    if (widget.isActive) {
      _startAnimations();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _imageController.reset();
      _textController.reset();
      _startAnimations();
    }
  }

  void _startAnimations() {
    _imageController.forward();
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        _textController.forward();
      }
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
      child: Column(
        children: [
          SizedBox(height: context.screenHeight * 0.05),
          FadeTransition(
            opacity: _imageFadeAnimation,
            child: ScaleTransition(
              scale: _imageScaleAnimation,
              child: Container(
                height: context.screenHeight * 0.4,
                width: double.infinity * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primary.withValues(alpha: 0.08),
                      blurRadius: AppSizes.radiusLarge,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                  child: Image.asset(
                    widget.item.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColor.greyLight.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusXl,
                          ),
                        ),
                        child: Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: AppColor.greySoft,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.screenHeight * 0.06),
          FadeTransition(
            opacity: _textFadeAnimation,
            child: SlideTransition(
              position: _textSlideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.item.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heading2.withColor(AppColor.black),
                  ),
                  SizedBox(height: AppSizes.spacingLarge),
                  Text(
                    widget.item.description,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body.withColor(AppColor.greyMedium),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
