import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.paddingXl),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with logo
            Container(
              padding: EdgeInsets.all(AppSizes.paddingMedium),
              decoration: BoxDecoration(
                color: const Color(0xFFE03A47).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                border: Border.all(
                  color: const Color(0xFFE03A47).withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Image.asset(
                "assets/images/logo_raho.png",
                width: 120,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: AppSizes.spacingLarge),
            Text(
              l10n.logoutDialogTitle,
              style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingSmall),
            Text(
              l10n.logoutDialogMessage,
              style: AppTextStyle.body.withColor(
                colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingXl),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.paddingMedium,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusLarge,
                          ),
                          border: Border.all(
                            color: colorScheme.outline.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          l10n.logoutCancelButton,
                          style: AppTextStyle.body.withColor(
                            colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.spacingMedium),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                      },
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.paddingMedium,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBF360C),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusLarge,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFFBF360C,
                              ).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: const Color(0xFFFFFFFF),
                              size: 18,
                            ),
                            SizedBox(width: AppSizes.spacingTiny),
                            Text(
                              l10n.logoutConfirmButton,
                              style: AppTextStyle.body.withColor(
                                const Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
