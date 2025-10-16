import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_assets.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/repositories/auth_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/password/create_password_bloc.dart';
import 'package:raho_member_apps/presentation/authentication/ui/background_wrapper.dart';
import 'package:raho_member_apps/presentation/widgets/primary_button.dart';
import 'package:raho_member_apps/presentation/widgets/primary_textfield.dart';
import 'package:raho_member_apps/presentation/widgets/snackbar_toast.dart';

class CreatePasswordPage extends StatefulWidget {
  final String patientId;

  const CreatePasswordPage({super.key, required this.patientId});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => sl<CreatePasswordBloc>(),
      child: BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
        listener: (context, state) {
          if (state is CreatePasswordSuccess) {
            AppNotification.success(
              context,
              state.message,
              duration: NotificationDuration.medium,
            );
            context.goNamed(AppRoutes.login.name);
          } else if (state is CreatePasswordFailure) {
            AppNotification.error(
              context,
              state.error,
              duration: NotificationDuration.medium,
              showCloseButton: true,
            );
          }
        },
        builder: (context, state) {
          return BackgroundWrapper(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppSizes.paddingLarge,
                      bottom: AppSizes.paddingXl,
                    ),
                    child: Image.asset(AppAssets.password, width: 120),
                  ),
                  Text(l10n.createPassword, style: AppTextStyle.title),
                  SizedBox(height: AppSizes.spacingMedium),
                  SizedBox(
                    width: 250,
                    child: Text(
                      l10n.createPasswordSupportText,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.body.withWeight(AppFontWeight.light),
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingXl),
                  PrimaryTextField(
                    hintText: l10n.createPasswordHintText,
                    prefixIcon: Icons.lock,
                    controller: passwordController,
                    obscureText: true,
                    showPasswordToggle: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.passwordEmptyError;
                      }
                      if (value.length < 8) {
                        return l10n.passwordMinLengthError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.spacingMedium),
                  PrimaryTextField(
                    hintText: l10n.confirmPasswordLabel,
                    prefixIcon: Icons.lock,
                    controller: confirmPasswordController,
                    obscureText: true,
                    showPasswordToggle: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.confirmPasswordEmptyError;
                      }
                      if (value != passwordController.text) {
                        return l10n.passwordMismatchError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.spacingXl),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: state is CreatePasswordLoading
                          ? l10n.processingText
                          : l10n.passwordButton,
                      onPressed: state is CreatePasswordLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<CreatePasswordBloc>().add(
                                  CreatePasswordSubmitted(
                                    patientId: widget.patientId,
                                    password: passwordController.text,
                                  ),
                                );
                              }
                            },
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingXl),
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
            ),
          );
        },
      ),
    );
  }
}
