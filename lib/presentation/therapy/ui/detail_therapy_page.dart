import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/detail_therapy.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/presentation/therapy/states/therapy/therapy_bloc.dart';

class DetailTherapyPageWrapper extends StatelessWidget {
  final int therapyId;

  const DetailTherapyPageWrapper({super.key, required this.therapyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TherapyBloc>()..add(FetchTherapyDetail(therapyId)),
      child: DetailTherapyPage(therapyId: therapyId),
    );
  }
}

class DetailTherapyPage extends StatefulWidget {
  final int therapyId;

  const DetailTherapyPage({super.key, required this.therapyId});

  @override
  State<DetailTherapyPage> createState() => _DetailTherapyPageState();
}

class _DetailTherapyPageState extends State<DetailTherapyPage> {
  int _selectedTabIndex = 0;
  int _selectedSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BackdropApps(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Container(
            padding: EdgeInsets.only(
              top: AppSizes.spacingXl,
              left: AppSizes.paddingLarge,
              right: AppSizes.paddingLarge,
              bottom: AppSizes.paddingMedium,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: colorScheme.onSurface,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
                Expanded(
                  child: Text(
                    l10n.therapyDetailTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.title.withColor(colorScheme.onSurface),
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
          ),
        ),
        body: BlocBuilder<TherapyBloc, TherapyState>(
          builder: (context, state) {
            if (state is TherapyDetailLoading) {
              return Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              );
            }

            if (state is TherapyError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: colorScheme.error,
                    ),
                    SizedBox(height: AppSizes.spacingMedium),
                    Text(
                      state.message,
                      style: AppTextStyle.subtitle.withColor(colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSizes.spacingMedium),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TherapyBloc>().add(
                          FetchTherapyDetail(widget.therapyId),
                        );
                      },
                      child: Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (state is TherapyDetailLoaded) {
              final detailTherapy = state.therapyDetail;

              return Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusXl),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusXl),
                  ),
                  child: Column(
                    children: [
                      // Header Section
                      Container(
                        padding: EdgeInsets.all(AppSizes.paddingLarge),
                        child: _buildHeaderSection(
                          colorScheme,
                          l10n,
                          detailTherapy,
                        ),
                      ),
                      // Content Section
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLarge,
                          ),
                          child: Column(
                            children: [
                              _buildTabNavigation(colorScheme, l10n),
                              SizedBox(height: AppSizes.spacingMedium),
                              Expanded(
                                child: _selectedTabIndex == 0
                                    ? _buildTherapyHistoryContent(
                                        colorScheme,
                                        l10n,
                                        detailTherapy,
                                      )
                                    : _buildSurveyHistoryContent(
                                        colorScheme,
                                        l10n,
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

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailTherapyModel detailTherapy,
  ) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.primary, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/person.jpg",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: colorScheme.onSurface.withAlpha(128),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  l10n.therapyInfoMember,
                  detailTherapy.memberName,
                  colorScheme,
                ),
                SizedBox(height: AppSizes.spacingTiny),
                _buildInfoRow(
                  l10n.therapyInfoDate,
                  detailTherapy.therapyDate,
                  colorScheme,
                ),
                SizedBox(height: AppSizes.spacingSmall),
                _buildStartSurveyButton(colorScheme, l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: AppTextStyle.caption.withColor(colorScheme.onSurface),
          ),
        ),
        SizedBox(width: AppSizes.spacingTiny),
        Text(":", style: AppTextStyle.caption.withColor(colorScheme.onSurface)),
        SizedBox(width: AppSizes.spacingTiny),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.caption
                .withColor(colorScheme.onSurface)
                .withWeight(AppFontWeight.medium),
          ),
        ),
      ],
    );
  }

  Widget _buildStartSurveyButton(
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(
        Icons.play_arrow_rounded,
        size: 16,
        color: colorScheme.onPrimary,
      ),
      label: Text(
        l10n.therapyStartSurvey,
        style: AppTextStyle.supportText.withColor(colorScheme.onPrimary),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildTabNavigation(ColorScheme colorScheme, AppLocalizations l10n) {
    return Row(
      children: [
        _buildTabButton(l10n.therapyTabHistory, 0, colorScheme),
        SizedBox(width: AppSizes.spacingSmall),
        _buildTabButton(l10n.therapyTabSurvey, 1, colorScheme),
      ],
    );
  }

  Widget _buildTabButton(String title, int index, ColorScheme colorScheme) {
    final isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Text(
          title,
          style: AppTextStyle.caption
              .withColor(
                isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              )
              .withWeight(AppFontWeight.medium),
        ),
      ),
    );
  }

  Widget _buildTherapyHistoryContent(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailTherapyModel detailTherapy,
  ) {
    // Get infus type from layanan
    final infusType = detailTherapy.layanan.isNotEmpty
        ? detailTherapy.layanan.map((l) => l.name).join(', ')
        : '-';

    // Calculate next infus date (7 days after therapy date)
    final nextInfusDate = _calculateNextInfusDate(detailTherapy.therapyDate);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(l10n.therapyInfoCardTitle, [
            _buildDetailRow(
              l10n.therapyInfusNumber,
              detailTherapy.infus.toString(),
              colorScheme,
            ),
            _buildDetailRow(l10n.therapyInfusType, infusType, colorScheme),
            _buildDetailRow(
              l10n.therapyProductionDate,
              detailTherapy.productionDate,
              colorScheme,
            ),
            _buildDetailRow(
              l10n.therapyNextInfusDate,
              nextInfusDate,
              colorScheme,
            ),
          ], colorScheme),

          SizedBox(height: AppSizes.spacingMedium),

          _buildHealingCrisisCard(colorScheme, l10n, detailTherapy),

          SizedBox(height: AppSizes.spacingMedium),

          _buildNeedleUsageCard(colorScheme, l10n, detailTherapy),

          SizedBox(height: AppSizes.spacingMedium),

          _buildSectionTabs(colorScheme, l10n),

          SizedBox(height: AppSizes.spacingMedium),

          if (_selectedSectionIndex == 0)
            _buildAnamnesisCard(colorScheme, l10n, detailTherapy)
          else
            _buildLabPhotoCard(colorScheme, l10n),

          SizedBox(height: AppSizes.spacingXl),
        ],
      ),
    );
  }

  String _calculateNextInfusDate(String therapyDate) {
    try {
      // Parse the date and add 7 days
      // You might need to adjust this based on your date format
      return therapyDate; // Placeholder - implement actual date calculation
    } catch (e) {
      return therapyDate;
    }
  }

  Widget _buildSurveyHistoryContent(
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 64,
            color: colorScheme.onSurface.withAlpha(128),
          ),
          SizedBox(height: AppSizes.spacingMedium),
          Text(
            l10n.therapyTabSurvey,
            style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingTiny),
          Text(
            l10n.therapySurveyEmpty,
            style: AppTextStyle.caption.withColor(
              colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    List<Widget> children,
    ColorScheme colorScheme,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.subtitle
                .withColor(colorScheme.onSurface)
                .withWeight(AppFontWeight.bold),
          ),
          SizedBox(height: AppSizes.spacingSmall),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingTiny),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyle.caption.withColor(colorScheme.onSurface),
            ),
          ),
          SizedBox(width: AppSizes.spacingTiny),
          Text(
            ":",
            style: AppTextStyle.caption.withColor(colorScheme.onSurface),
          ),
          SizedBox(width: AppSizes.spacingTiny),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.caption
                  .withColor(colorScheme.onSurface)
                  .withWeight(AppFontWeight.medium),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealingCrisisCard(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailTherapyModel detailTherapy,
  ) {
    final healingCrisis = detailTherapy.healingCrisis;
    final notes = detailTherapy.actionForHealing;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.therapyHealingCrisisTitle,
            style: AppTextStyle.subtitle
                .withColor(colorScheme.onSurface)
                .withWeight(AppFontWeight.bold),
          ),
          SizedBox(height: AppSizes.spacingSmall),

          Text(
            l10n.therapyHealingCrisisComplaint,
            style: AppTextStyle.caption.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingTiny),
          _buildTextFormField(healingCrisis, colorScheme, maxLines: 2),

          SizedBox(height: AppSizes.spacingSmall),

          Text(
            l10n.therapyHealingCrisisNote,
            style: AppTextStyle.caption.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingTiny),
          _buildTextFormField(notes, colorScheme, maxLines: 2),
        ],
      ),
    );
  }

  Widget _buildNeedleUsageCard(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailTherapyModel detailTherapy,
  ) {
    // Convert jarum data to display format
    final needleData = detailTherapy.jarum.map((jarum) {
      return {
        'needle': jarum.name,
        'nakes': jarum.nakes,
        'status': jarum.status,
      };
    }).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.therapyNeedleUsageTitle,
            style: AppTextStyle.subtitle
                .withColor(colorScheme.onSurface)
                .withWeight(AppFontWeight.bold),
          ),
          SizedBox(height: AppSizes.spacingSmall),

          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme.surfaceContainerHighest,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(AppSizes.paddingMedium),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSizes.radiusSmall),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.therapyNeedleUsageHeaderNeedle,
                          style: AppTextStyle.caption
                              .withColor(colorScheme.onSurface)
                              .withWeight(AppFontWeight.medium),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          l10n.therapyNeedleUsageHeaderNakes,
                          style: AppTextStyle.caption
                              .withColor(colorScheme.onSurface)
                              .withWeight(AppFontWeight.medium),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          l10n.therapyNeedleUsageHeaderStatus,
                          style: AppTextStyle.caption
                              .withColor(colorScheme.onSurface)
                              .withWeight(AppFontWeight.medium),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Data rows
                if (needleData.isEmpty)
                  Container(
                    padding: EdgeInsets.all(AppSizes.paddingMedium),
                    child: Text(
                      l10n.needleDataEmpty,
                      style: AppTextStyle.caption.withColor(
                        colorScheme.onSurface.withAlpha(128),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  ...needleData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    final isLast = index == needleData.length - 1;

                    return Container(
                      padding: EdgeInsets.all(AppSizes.paddingMedium),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? colorScheme.surface
                            : colorScheme.surfaceContainerHighest.withAlpha(64),
                        borderRadius: isLast
                            ? BorderRadius.vertical(
                                bottom: Radius.circular(AppSizes.radiusSmall),
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              data['needle'] ?? '-',
                              style: AppTextStyle.caption.withColor(
                                colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              data['nakes'] ?? '-',
                              style: AppTextStyle.caption.withColor(
                                colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.paddingTiny,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: data['status'] == l10n.therapyNeedleUsed
                                    ? colorScheme.primary.withAlpha(26)
                                    : colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusTiny,
                                ),
                              ),
                              child: Text(
                                data['status'] ?? '-',
                                style: AppTextStyle.supportText.withColor(
                                  data['status'] == l10n.therapyNeedleUsed
                                      ? colorScheme.primary
                                      : colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTabs(ColorScheme colorScheme, AppLocalizations l10n) {
    return Row(
      children: [
        _buildSectionTabButton(l10n.therapySectionAnamnesis, 0, colorScheme),
        SizedBox(width: AppSizes.spacingSmall),
        _buildSectionTabButton(l10n.therapySectionLabPhoto, 1, colorScheme),
      ],
    );
  }

  Widget _buildSectionTabButton(
    String title,
    int index,
    ColorScheme colorScheme,
  ) {
    final isSelected = _selectedSectionIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedSectionIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Text(
          title,
          style: AppTextStyle.caption
              .withColor(
                isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              )
              .withWeight(AppFontWeight.medium),
        ),
      ),
    );
  }

  Widget _buildAnamnesisCard(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailTherapyModel detailTherapy,
  ) {
    final monitoringMap = <String, MonitoringModel>{};
    for (final monitoring in detailTherapy.monitoring) {
      monitoringMap['${monitoring.pencatatan}-${monitoring.waktu}'] =
          monitoring;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.therapySectionAnamnesis,
            style: AppTextStyle.subtitle
                .withColor(colorScheme.onSurface)
                .withWeight(AppFontWeight.bold),
          ),
          SizedBox(height: AppSizes.spacingMedium),

          Text(
            l10n.therapyComplaintAfter,
            style: AppTextStyle.caption.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingTiny),
          _buildTextFormField(
            detailTherapy.complaintAfter,
            colorScheme,
            hintText: l10n.therapyNoComplaint,
          ),

          SizedBox(height: AppSizes.spacingSmall),

          Text(
            l10n.therapyComplaintBefore,
            style: AppTextStyle.caption.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingTiny),
          _buildTextFormField(
            detailTherapy.complaintPrevious,
            colorScheme,
            hintText: l10n.therapyNoComplaint,
          ),

          SizedBox(height: AppSizes.spacingMedium),

          _buildVitalSignsSection(colorScheme, l10n, monitoringMap),
        ],
      ),
    );
  }

  Widget _buildLabPhotoCard(ColorScheme colorScheme, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 48,
            color: colorScheme.onSurface.withAlpha(128),
          ),
          SizedBox(height: AppSizes.spacingMedium),
          Text(
            l10n.therapySectionLabPhoto,
            style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingTiny),
          Text(
            l10n.therapyLabPhotoEmpty,
            style: AppTextStyle.caption.withColor(
              colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignsSection(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    Map<String, MonitoringModel> monitoringMap,
  ) {
    String getValue(String pencatatan, String waktu) {
      final key = '$pencatatan-$waktu';
      final monitoring = monitoringMap[key];
      if (monitoring != null) {
        return monitoring.hasil.toString();
      }
      return '0';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.therapyVitalSignBloodPressure,
          style: AppTextStyle.caption
              .withColor(colorScheme.onSurface)
              .withWeight(AppFontWeight.bold),
        ),
        SizedBox(height: AppSizes.spacingTiny),

        Row(
          children: [
            Expanded(
              child: _buildVitalCard(
                l10n.therapyVitalSignSystolic,
                "${getValue('Sistol', 'Sebelum')} → ${getValue('Sistol', 'Sesudah')}",
                colorScheme,
              ),
            ),
            SizedBox(width: AppSizes.spacingSmall),
            Expanded(
              child: _buildVitalCard(
                l10n.therapyVitalSignDiastolic,
                "${getValue('Diastol', 'Sebelum')} → ${getValue('Diastol', 'Sesudah')}",
                colorScheme,
              ),
            ),
          ],
        ),

        SizedBox(height: AppSizes.spacingMedium),

        Text(
          l10n.therapyVitalSignO2AndHR,
          style: AppTextStyle.caption
              .withColor(colorScheme.onSurface)
              .withWeight(AppFontWeight.bold),
        ),
        SizedBox(height: AppSizes.spacingTiny),

        _buildVitalDetailCard(colorScheme, l10n, monitoringMap),
      ],
    );
  }

  Widget _buildVitalCard(String title, String value, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.supportText.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingTiny),
          Text(
            value,
            style: AppTextStyle.caption
                .withColor(colorScheme.onSurface)
                .withWeight(AppFontWeight.medium),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalDetailCard(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    Map<String, MonitoringModel> monitoringMap,
  ) {
    // Extract values based on pencatatan type and waktu
    String getValue(String pencatatan, String waktu) {
      final key = '$pencatatan-$waktu';
      final monitoring = monitoringMap[key];
      if (monitoring != null && monitoring.hasil! > 0) {
        return monitoring.hasil.toString();
      }
      return '-';
    }

    final vitalData = [
      {
        'label': l10n.therapyVitalSaturationBefore,
        'value': getValue('Saturasi', 'Sebelum'),
      },
      {
        'label': l10n.therapyVitalSaturationAfter,
        'value': getValue('Saturasi', 'Sesudah'),
      },
      {
        'label': l10n.therapyVitalPerfusionBefore,
        'value': getValue('PI', 'Sebelum'),
      },
      {
        'label': l10n.therapyVitalPerfusionAfter,
        'value': getValue('PI', 'Sesudah'),
      },
      {'label': l10n.therapyVitalHRBefore, 'value': getValue('HR', 'Sebelum')},
      {'label': l10n.therapyVitalHRAfter, 'value': getValue('HR', 'Sesudah')},
    ];

    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: Column(
        children: vitalData.map((data) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.paddingTiny),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data['label']!,
                  style: AppTextStyle.caption.withColor(colorScheme.onSurface),
                ),
                Text(
                  data['value']!,
                  style: AppTextStyle.caption
                      .withColor(colorScheme.onSurface)
                      .withWeight(AppFontWeight.medium),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextFormField(
    String initialValue,
    ColorScheme colorScheme, {
    String? hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      readOnly: true,
      // Make it read-only since this is detail view
      style: AppTextStyle.caption.withColor(colorScheme.onSurface),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.caption.withColor(
          colorScheme.onSurface.withAlpha(128),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide(
            color: colorScheme.surfaceContainerHighest,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide(
            color: colorScheme.surfaceContainerHighest,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
