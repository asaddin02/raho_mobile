import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/storage/app_storage_service.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/data/repositories/otp_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/cubit/otp/otp_cubit.dart';
import 'package:raho_member_apps/presentation/authentication/states/verification_number/verify_number_bloc.dart';
import 'package:raho_member_apps/presentation/authentication/ui/background_wrapper.dart';
import 'package:raho_member_apps/presentation/authentication/ui/widget/otp_textfield.dart';

class OtpWrapper extends StatelessWidget {
  final String idRegister;
  final String mobile;

  const OtpWrapper({super.key, required this.idRegister, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OtpCubit(otpLength: 6)),
        BlocProvider(
          create: (context) =>
          sl<VerifyNumberBloc>()
                ..add(ValidateNumberEvent(idRegister: idRegister)),
        ),
      ],
      child: OtpPage(idRegister: idRegister, mobile: mobile),
    );
  }
}

class OtpPage extends StatefulWidget {
  final String idRegister;
  final String mobile;

  const OtpPage({super.key, required this.idRegister, required this.mobile});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final int length = 6;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<VerifyNumberBloc, VerifyNumberState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          context.read<OtpCubit>().clearAllDigits();
          context.goNamed(
            AppRoutes.createPassword.name,
            pathParameters: {'patientId': widget.idRegister},
          );
        } else if (state is ResendOtpSuccess) {
          context.read<OtpCubit>().clearAllDigits();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.getLocalizedMessage(context)),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ResendOtpAlreadyVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.getLocalizedMessage(context)),
              backgroundColor: Colors.blue,
            ),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (state is VerifyNumberError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.getLocalizedMessage(context)),
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
              // Header Section
              Container(
                padding: EdgeInsets.all(AppSizes.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: Icon(
                  Icons.security_rounded,
                  size: 72,
                  color: AppColor.primary,
                ),
              ),
              SizedBox(height: AppSizes.spacingXl),

              // Title Section
              Text(
                l10n.otpTitle,
                style: AppTextStyle.title.withColor(AppColor.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spacingMedium),
              richTextFromIntl(
                text: l10n.otpSubtitle('number_phone'),
                highlight: {
                  widget.mobile: AppTextStyle.body
                      .withWeight(AppFontWeight.black)
                      .withColor(AppColor.greyMedium),
                },
                defaultStyle: AppTextStyle.body
                    .withWeight(AppFontWeight.regular)
                    .withColor(AppColor.greyMedium),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spacingXl),

              Container(
                padding: EdgeInsets.all(AppSizes.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColor.greyLight.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  border: Border.all(
                    color: AppColor.greyLight.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    OtpTextField(
                      length: length,
                      onCompleted: (otp) {
                        context.read<VerifyNumberBloc>().add(
                          VerifyOtpEvent(
                            idRegister: widget.idRegister,
                            otpCode: otp,
                          ),
                        );
                      },
                      onChanged: (value) {},
                    ),
                    SizedBox(height: AppSizes.spacingLarge),

                    // Resend Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.otpNotReceive,
                          style: AppTextStyle.caption.withColor(
                            AppColor.greyMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: state is VerifyNumberLoading
                              ? null
                              : () {
                                  context.read<VerifyNumberBloc>().add(
                                    ResendOtpEvent(
                                      idRegister: widget.idRegister,
                                    ),
                                  );
                                },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingSmall,
                            ),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            state is VerifyNumberLoading
                                ? 'Loading...'
                                : l10n.otpResend,
                            style: AppTextStyle.caption
                                .withWeight(AppFontWeight.semiBold)
                                .withColor(
                                  state is VerifyNumberLoading
                                      ? AppColor.greyMedium
                                      : AppColor.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.spacingXl),

              // Verify Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  gradient: LinearGradient(
                    colors: [AppColor.primary, AppColor.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primary.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, otpState) {
                    final isOtpReady =
                        otpState is OtpInProgress &&
                        otpState.isComplete &&
                        otpState.isValid;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.paddingLarge,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusLarge,
                          ),
                        ),
                      ),
                      onPressed: state is VerifyNumberLoading || !isOtpReady
                          ? null
                          : () {
                              final otpCode = context
                                  .read<OtpCubit>()
                                  .currentOtp;
                              context.read<VerifyNumberBloc>().add(
                                VerifyOtpEvent(
                                  idRegister: widget.idRegister,
                                  otpCode: otpCode,
                                ),
                              );
                            },
                      child: state is VerifyNumberLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.white,
                                ),
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              l10n.otpButton,
                              style: AppTextStyle.subtitle
                                  .withWeight(AppFontWeight.bold)
                                  .withColor(AppColor.white),
                            ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSizes.spacingXl),
              Text(
                l10n.supportedBy,
                style: AppTextStyle.supportText.withColor(AppColor.greySoft),
              ),
              SizedBox(width: AppSizes.spacingSmall),
              Text(
                l10n.companyName,
                style: AppTextStyle.subtitle.withWeight(AppFontWeight.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
