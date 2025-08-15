import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_assets.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/extensions.dart';
import 'package:raho_member_apps/data/repositories/otp_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/verification_number/verify_number_bloc.dart';
import 'package:raho_member_apps/presentation/authentication/ui/background_wrapper.dart';
import 'package:raho_member_apps/presentation/widgets/primary_button.dart';
import 'package:raho_member_apps/presentation/widgets/primary_textfield.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => VerifyNumberBloc(repository: sl<OtpRepository>()),
      child: BlocConsumer<VerifyNumberBloc, VerifyNumberState>(
        listener: (context, state) {
          if (state is ValidateNumberOtpSent) {
            context.pushNamed(
              AppRoutes.otp.name,
              pathParameters: {
                'id_register': state.idRegister,
                'mobile': state.mobile,
              },
            );
          } else if (state is ValidateNumberAlreadyVerified) {
            context.pushNamed(AppRoutes.login.name);
          } else if (state is VerifyNumberError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return BackgroundWrapper(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 800),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: AppSizes.paddingLarge,
                            bottom: AppSizes.paddingXl,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(AppSizes.paddingMedium),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  blurRadius: 15,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Image.asset(AppAssets.logoApp, width: 120),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Title Section
                TweenAnimationBuilder<Offset>(
                  duration: Duration(milliseconds: 600),
                  tween: Tween(begin: Offset(0, 50), end: Offset.zero),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: value,
                      child: Opacity(
                        opacity: 1 - (value.dy / 50),
                        child: Text(
                          l10n.verificationTitle,
                          style: AppTextStyle.title.withWeight(
                            AppFontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.spacingMedium),
                TweenAnimationBuilder<Offset>(
                  duration: Duration(milliseconds: 800),
                  tween: Tween(begin: Offset(0, 30), end: Offset.zero),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: value,
                      child: Opacity(
                        opacity: 1 - (value.dy / 30),
                        child: SizedBox(
                          width: context.screenWidth * 0.8,
                          child: Text(
                            l10n.verificationSubtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.body
                                .withWeight(AppFontWeight.regular)
                                .withColor(AppColor.greyDark),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.spacingXl),
                PrimaryTextField(
                  controller: _idController,
                  hintText: l10n.idRegisterHintText,
                  prefixIcon: Icons.people,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: AppSizes.spacingXl),
                PrimaryButton(
                  text: l10n.verificationButton,
                  isLoading: state is VerifyNumberLoading,
                  onPressed: () {
                    if (_idController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter ID Register'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    context.read<VerifyNumberBloc>().add(
                      ValidateNumberEvent(
                        idRegister: _idController.text.trim(),
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.spacingXl),
                Column(
                  children: [
                    Text(
                      l10n.supportedBy,
                      style: AppTextStyle.supportText.withColor(
                        AppColor.greySoft,
                      ),
                    ),
                    SizedBox(width: AppSizes.spacingSmall),
                    Text(
                      l10n.companyName,
                      style: AppTextStyle.subtitle.withWeight(
                        AppFontWeight.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
