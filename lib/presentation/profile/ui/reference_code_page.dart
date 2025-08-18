import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/profile/states/references/references_cubit.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';

class ReferenceCodeWrapper extends StatelessWidget {
  const ReferenceCodeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReferenceCubit>()..getReference(),
      child: ReferenceCodePage(),
    );
  }
}

class ReferenceCodePage extends StatelessWidget {
  const ReferenceCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.spacingXxl,
          left: AppSizes.paddingMedium,
          right: AppSizes.paddingMedium,
        ),
        child: Column(
          children: [
            // Header
            Container(
              margin: EdgeInsets.only(
                bottom: AppSizes.spacingLarge,
                left: AppSizes.paddingMedium,
                right: AppSizes.paddingMedium,
              ),
              width: double.infinity,
              height: 32,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: EdgeInsets.all(AppSizes.paddingSmall),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(51),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      l10n.referenceCodeMenuTitle,
                      style: AppTextStyle.title.withColor(
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content card
            Expanded(
              child: Container(
                padding: EdgeInsets.all(AppSizes.paddingLarge),
                width: double.infinity,
                margin: EdgeInsets.only(
                  bottom: AppSizes.paddingMedium,
                  left: AppSizes.paddingTiny,
                  right: AppSizes.paddingTiny,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.06,
                      ),
                      blurRadius: 24,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header info
                    Container(
                      padding: EdgeInsets.only(bottom: AppSizes.spacingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.referenceInfoTitle,
                            style: AppTextStyle.title.withColor(
                              theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Form fields
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: BlocBuilder<ReferenceCubit, ReferenceState>(
                          builder: (context, state) {
                            if (state is ReferenceLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: theme.colorScheme.primary,
                                ),
                              );
                            }
                            if (state is ReferenceError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 64,
                                      color: Colors.red[300],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      l10n.referenceErrorMessage(
                                        state.messageCode,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ReferenceCubit>()
                                            .getReference();
                                      },
                                      child: Text(l10n.retry),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is ReferenceLoaded) {
                              return Column(
                                children: [
                                  _buildInputField(
                                    context: context,
                                    label: l10n.referralNameFieldLabel,
                                    hint: state.reference.name ?? '-',
                                  ),
                                  SizedBox(height: AppSizes.spacingMedium),
                                  _buildInputField(
                                    context: context,
                                    label: l10n.cardNumberFieldLabel,
                                    hint: state.reference.noCard ?? '-',
                                  ),
                                ],
                              );
                            }
                            return Center(child: Text(l10n.referenceNoData));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required String label,
    required String hint,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.subtitle.withColor(theme.colorScheme.onSurface),
        ),
        SizedBox(height: AppSizes.spacingTiny),
        TextFormField(
          style: AppTextStyle.body.withColor(theme.colorScheme.onSurface),
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyle.body.withColor(
              isDark ? AppColor.grey : AppColor.greyMedium,
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.4,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingMedium,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              borderSide: BorderSide(
                color: isDark ? AppColor.greyDark : AppColor.greyLight,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              borderSide: BorderSide(
                color: isDark ? AppColor.greyDark : AppColor.greyLight,
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
              borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
