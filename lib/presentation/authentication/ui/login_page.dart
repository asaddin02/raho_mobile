import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_assets.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/presentation/authentication/states/password_visibility/password_visibility_cubit.dart';
import 'package:raho_member_apps/presentation/dashboard/states/notification/notification_bloc.dart';
import 'package:raho_member_apps/presentation/widgets/snackbar_toast.dart';

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PasswordVisibilityCubit>(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idRegister = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    idRegister.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.highlightColor.withValues(alpha: 0.1),
              theme.highlightColor.withValues(alpha: 0.05),
              theme.scaffoldBackgroundColor,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    AppNotification.success(
                      context,
                      state.message,
                      duration: NotificationDuration.medium,
                    );
                    context.read<NotificationBloc>().add(
                      InitializeNotifications(),
                    );
                    context.goNamed(AppRoutes.dashboard.name);
                  } else if (state is AuthFailure) {
                    AppNotification.error(
                      context,
                      state.error,
                      duration: NotificationDuration.medium,
                      showCloseButton: true,
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.logoApp, width: 100),
                    SizedBox(height: AppSizes.spacingLarge),
                    Text(
                      l10n.loginTitle,
                      style: AppTextStyle.title.withColor(
                        theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: AppSizes.spacingTiny),
                    Text(
                      l10n.loginSubtitle,
                      style: AppTextStyle.caption.withColor(
                        theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: AppSizes.spacingXxl),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSizes.paddingLarge),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusLarge,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.1),
                            blurRadius: AppSizes.radiusLarge,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.idRegisterLabel,
                            style: AppTextStyle.caption.withColor(
                              theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: AppSizes.spacingSmall),
                          _buildIdRegisterField(theme, l10n),
                          SizedBox(height: AppSizes.spacingLarge),
                          Text(
                            l10n.passwordLabel,
                            style: AppTextStyle.caption.withColor(
                              theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: AppSizes.spacingSmall),
                          _buildPasswordField(theme, l10n),
                          SizedBox(height: AppSizes.spacingXl),
                          _buildLoginButton(theme, l10n),
                          SizedBox(height: AppSizes.spacingMedium),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                l10n.forgotPasswordButton,
                                style: AppTextStyle.caption.withColor(
                                  theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.spacingXl),
                    Text(
                      l10n.supportedBy,
                      style: AppTextStyle.supportText.withColor(
                        theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: AppSizes.spacingTiny),
                    Text(
                      l10n.companyName,
                      style: AppTextStyle.subtitle
                          .withWeight(AppFontWeight.black)
                          .withColor(
                            theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdRegisterField(ThemeData theme, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: idRegister,
        style: AppTextStyle.body.withColor(theme.colorScheme.onSurface),
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: EdgeInsets.all(AppSizes.paddingMedium),
            child: Icon(
              Icons.person_outline_rounded,
              color: theme.colorScheme.primary,
            ),
          ),
          contentPadding: EdgeInsets.all(AppSizes.paddingLarge),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.3,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
          ),
          hintText: l10n.idRegisterHintText,
          hintStyle: AppTextStyle.caption.withColor(
            theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(ThemeData theme, AppLocalizations l10n) {
    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isPasswordVisible) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: password,
            obscureText: !isPasswordVisible,
            style: AppTextStyle.body.withColor(theme.colorScheme.onSurface),
            decoration: InputDecoration(
              prefixIcon: Container(
                padding: EdgeInsets.all(AppSizes.paddingMedium),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: theme.colorScheme.primary,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<PasswordVisibilityCubit>().toggle();
                },
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: isPasswordVisible
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 20,
                ),
                constraints: BoxConstraints(minWidth: 40, minHeight: 40),
              ),
              contentPadding: EdgeInsets.all(AppSizes.paddingLarge),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                borderSide: BorderSide(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                  width: 1,
                ),
              ),
              hintText: l10n.passwordHintText,
              hintStyle: AppTextStyle.caption.withColor(
                theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginButton(ThemeData theme, AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: AppSizes.paddingLarge),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
                    if (idRegister.text.isNotEmpty &&
                        password.text.isNotEmpty) {
                      context.read<AuthBloc>().add(
                        AuthLoginRequested(
                          idRegistration: idRegister.text,
                          password: password.text,
                        ),
                      );
                    } else {
                      AppNotification.warning(
                        context,
                        l10n.loginErrorRequiredField,
                      );
                    }
                  },
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                    ),
                  )
                : Text(
                    l10n.loginButton,
                    style: AppTextStyle.subtitle
                        .withWeight(AppFontWeight.bold)
                        .withColor(AppColor.white),
                  ),
          ),
        );
      },
    );
  }
}
