import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/data/models/diagnosis.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/profile/states/profile/profile_bloc.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';

class MyDiagnosisWrapper extends StatelessWidget {
  const MyDiagnosisWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(GetDiagnosis()),
      child: MyDiagnosisPage(),
    );
  }
}

class MyDiagnosisPage extends StatefulWidget {
  const MyDiagnosisPage({super.key});

  @override
  State<MyDiagnosisPage> createState() => _MyDiagnosisPageState();
}

class _MyDiagnosisPageState extends State<MyDiagnosisPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.spacingXl + AppSizes.spacingMedium,
          left: AppSizes.paddingMedium,
          right: AppSizes.paddingMedium,
        ),
        child: Column(
          children: [
            // Header Section
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
                          color: theme.colorScheme.onSurface.withAlpha(51),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: theme.colorScheme.onSurface,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      l10n.diagnosisMenuTitle,
                      style: AppTextStyle.title.withColor(
                        theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content Section
            Expanded(child: _buildContent(theme, l10n)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme, AppLocalizations l10n) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          );
        }

        if (state is ProfileError) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.paddingLarge),
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
                      color: theme.colorScheme.onSurface.withAlpha(25),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildErrorWidget(theme, state.messageCode, l10n),
              ),
            ],
          );
        }

        if (state is ProfileDiagnosisLoaded) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.paddingLarge),
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
                      color: theme.colorScheme.onSurface.withAlpha(25),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildDiagnosisContent(state.diagnosis, theme, l10n),
              ),
            ],
          );
        }

        // Default empty state
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.paddingLarge),
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
                    color: theme.colorScheme.onSurface.withAlpha(25),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: _buildEmptyWidget(theme, l10n),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDiagnosisContent(
    DiagnosisModel diagnosis,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileSection(diagnosis, theme),

        SizedBox(height: AppSizes.spacingLarge),

        _buildDiagnosisSection(
          l10n.diagnosisNoteTitle,
          diagnosis.note ?? '-',
          Icons.note_alt_outlined,
          theme,
        ),

        _buildDiagnosisSection(
          l10n.diagnosisCurrentIllnessTitle,
          diagnosis.currentIllness ?? '-',
          Icons.sick_outlined,
          theme,
        ),

        _buildDiagnosisSection(
          l10n.diagnosisPreviousIllnessTitle,
          diagnosis.previousIllness ?? '-',
          Icons.history_outlined,
          theme,
        ),

        _buildDiagnosisSection(
          l10n.diagnosisSocialHabitTitle,
          diagnosis.socialHabit ?? '-',
          Icons.people_outline,
          theme,
        ),

        _buildDiagnosisSection(
          l10n.diagnosisTreatmentHistoryTitle,
          diagnosis.treatmentHistory ?? '-',
          Icons.medication_outlined,
          theme,
        ),

        _buildDiagnosisSection(
          l10n.diagnosisPhysicalExamTitle,
          diagnosis.physicalExamination ?? '-',
          Icons.health_and_safety_outlined,
          theme,
        ),
      ],
    );
  }

  Widget _buildProfileSection(DiagnosisModel diagnosis, ThemeData theme) {
    String? b64;
    b64 = diagnosis.profileImage;
    final bytes = decodeBase64Image(b64);
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surface,
            ),
            child: CircleAvatar(
              radius: 42,
              backgroundColor: theme.colorScheme.primary.withAlpha(30),
              child: ClipOval(
                child: bytes != null
                    ? Image.memory(
                        bytes,
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        filterQuality: FilterQuality.medium,
                      )
                    : Image.asset(
                        "assets/images/person.png",
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diagnosis.name ?? '-',
                  style: AppTextStyle.subtitle
                      .withWeight(AppFontWeight.semiBold)
                      .withColor(theme.colorScheme.onPrimaryContainer),
                ),
                SizedBox(height: AppSizes.paddingTiny),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: theme.colorScheme.primary,
                      size: AppSizes.paddingMedium + 2,
                    ),
                    SizedBox(width: AppSizes.paddingTiny),
                    Expanded(
                      child: Text(
                        diagnosis.partnerName ?? '-',
                        style: AppTextStyle.caption.withColor(
                          theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.paddingTiny),
                Text(
                  diagnosis.noId ?? '-',
                  style: AppTextStyle.caption.withColor(AppColor.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisSection(
    String title,
    String content,
    IconData icon,
    ThemeData theme,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.spacingMedium),
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: theme.dividerColor.withAlpha(100),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: theme.colorScheme.primary,
                size: AppSizes.paddingLarge,
              ),
              SizedBox(width: AppSizes.paddingSmall),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.subtitle
                      .withWeight(AppFontWeight.semiBold)
                      .withColor(theme.colorScheme.onSurface),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.paddingSmall),
          Text(
            formatBulletPoints(content),
            style: AppTextStyle.body.withColor(
              theme.colorScheme.onSurface.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(
    ThemeData theme,
    String errorMessage,
    AppLocalizations l10n,
  ) {
    return Center(
      child: GestureDetector(
        onTap: () {
          context.read<ProfileBloc>().add(GetDiagnosis());
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          decoration: BoxDecoration(
            color: theme.colorScheme.error.withAlpha(20),
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            border: Border.all(
              color: theme.colorScheme.error.withAlpha(100),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
                size: AppSizes.spacingXl,
              ),
              SizedBox(height: AppSizes.paddingMedium),
              Text(
                errorMessage,
                style: AppTextStyle.body.withColor(theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.paddingMedium),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh,
                    color: theme.colorScheme.error,
                    size: AppSizes.paddingLarge,
                  ),
                  SizedBox(width: AppSizes.paddingSmall),
                  Text(
                    l10n.diagnosisReload,
                    style: AppTextStyle.subtitle.withColor(
                      theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(ThemeData theme, AppLocalizations l10n) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_outlined,
              color: theme.colorScheme.onSurface.withAlpha(100),
              size: AppSizes.spacingXl + AppSizes.paddingLarge,
            ),
            SizedBox(height: AppSizes.paddingMedium),
            Text(
              l10n.diagnosisEmpty,
              style: AppTextStyle.subtitle.withColor(
                theme.colorScheme.onSurface.withAlpha(150),
              ),
            ),
            SizedBox(height: AppSizes.paddingMedium),
            OutlinedButton.icon(
              onPressed: () {
                context.read<ProfileBloc>().add(GetDiagnosis());
              },
              icon: Icon(Icons.refresh),
              label: Text(l10n.diagnosisReloadButton),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
