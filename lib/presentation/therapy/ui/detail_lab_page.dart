import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/detail_lab.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/presentation/therapy/states/lab/lab_bloc.dart';

class DetailLabPageWrapper extends StatelessWidget {
  final int labId;

  const DetailLabPageWrapper({super.key, required this.labId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LabBloc>()..add(FetchLabDetail(labId)),
      child: DetailLabPage(labId: labId),
    );
  }
}

class DetailLabPage extends StatefulWidget {
  final int labId;

  const DetailLabPage({super.key, required this.labId});

  @override
  State<DetailLabPage> createState() => _DetailLabPageState();
}

class _DetailLabPageState extends State<DetailLabPage> {
  final ScrollController _horizontalScrollController = ScrollController();
  int _selectedTabIndex = 0;

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

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
                    l10n.labDetailTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.title.withColor(colorScheme.onSurface),
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
          ),
        ),
        body: BlocBuilder<LabBloc, LabState>(
          builder: (context, state) {
            if (state is LabDetailLoading) {
              return Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              );
            }

            if (state is LabDetailError) {
              return _buildErrorState(context, state, colorScheme, l10n);
            }

            if (state is LabDetailLoaded) {
              final detailLab = state.labDetail;

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
                  child: NestedScrollView(
                    headerSliverBuilder: (context, _) => [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(AppSizes.paddingLarge),
                          child: _buildHeaderSection(
                            colorScheme,
                            l10n,
                            detailLab,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLarge,
                          ),
                          child: _buildTabNavigation(colorScheme, l10n),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: AppSizes.spacingMedium),
                      ),
                    ],
                    body: _selectedTabIndex == 0
                        ? _buildResultsTab(colorScheme, l10n, detailLab)
                        : _buildAnalysisTab(colorScheme, l10n, detailLab),
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

  Widget _buildErrorState(
    BuildContext context,
    LabDetailError state,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: colorScheme.error),
          SizedBox(height: AppSizes.spacingMedium),
          Text(
            state.getLocalizedMessage(context),
            style: AppTextStyle.subtitle.withColor(colorScheme.error),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSizes.spacingMedium),
          ElevatedButton(
            onPressed: () {
              context.read<LabBloc>().add(FetchLabDetail(widget.labId));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLarge,
                vertical: AppSizes.paddingMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              ),
            ),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailLabModel detailLab,
  ) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withAlpha(204),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lab Header with Icon
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withAlpha(204),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withAlpha(51),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.biotech_rounded,
                  size: 28,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.labNumber,
                      style: AppTextStyle.caption.withColor(
                        colorScheme.onSurface.withAlpha(179),
                      ),
                    ),
                    SizedBox(height: AppSizes.spacingTiny),
                    Text(
                      detailLab.numberLab ?? '-',
                      style: AppTextStyle.title
                          .withColor(colorScheme.onSurface)
                          .withWeight(AppFontWeight.bold),
                    ),
                  ],
                ),
              ),
              _buildStatusChip(colorScheme, l10n, detailLab),
            ],
          ),

          SizedBox(height: AppSizes.spacingLarge),

          // Info Grid
          _buildInfoGrid(colorScheme, l10n, detailLab),

          // Diagnosis Section
          if (detailLab.diagnosa != null && detailLab.diagnosa != '-') ...[
            SizedBox(height: AppSizes.spacingLarge),
            _buildDiagnosisSection(colorScheme, l10n, detailLab),
          ],

          // Summary Cards
          SizedBox(height: AppSizes.spacingLarge),
          _buildSummaryCards(colorScheme, l10n, detailLab),
        ],
      ),
    );
  }

  Widget _buildStatusChip(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailLabModel detailLab,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColor.green.withAlpha(26),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: AppColor.green.withAlpha(51), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColor.green,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: AppSizes.spacingTiny),
          Text(
            'Complete',
            style: AppTextStyle.supportText
                .withColor(AppColor.green)
                .withWeight(AppFontWeight.medium),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGrid(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailLabModel detailLab,
  ) {
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
        children: [
          _buildInfoItem(
            Icons.person_outline_rounded,
            l10n.labPatient,
            detailLab.member,
            colorScheme,
          ),
          Divider(
            height: AppSizes.spacingMedium,
            color: colorScheme.surfaceContainerHighest,
          ),
          _buildInfoItem(
            Icons.medical_services_outlined,
            l10n.labDoctor,
            detailLab.dokter ?? '-',
            colorScheme,
          ),
          Divider(
            height: AppSizes.spacingMedium,
            color: colorScheme.surfaceContainerHighest,
          ),
          _buildInfoItem(
            Icons.calendar_today_outlined,
            l10n.labDate,
            detailLab.date ?? '-',
            colorScheme,
          ),
          Divider(
            height: AppSizes.spacingMedium,
            color: colorScheme.surfaceContainerHighest,
          ),
          _buildInfoItem(
            Icons.badge_outlined,
            l10n.labOfficer,
            detailLab.petugas ?? '-',
            colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.paddingSmall),
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(13),
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
          child: Icon(icon, size: 16, color: colorScheme.primary),
        ),
        SizedBox(width: AppSizes.spacingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.supportText.withColor(
                  colorScheme.onSurface.withAlpha(128),
                ),
              ),
              Text(
                value,
                style: AppTextStyle.caption
                    .withColor(colorScheme.onSurface)
                    .withWeight(AppFontWeight.medium),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiagnosisSection(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailLabModel detailLab,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withAlpha(13),
            colorScheme.primary.withAlpha(8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: colorScheme.primary.withAlpha(51), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_information_outlined,
                size: 18,
                color: colorScheme.primary,
              ),
              SizedBox(width: AppSizes.spacingSmall),
              Text(
                l10n.labDiagnosis,
                style: AppTextStyle.caption
                    .withColor(colorScheme.primary)
                    .withWeight(AppFontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingSmall),
          Text(
            detailLab.diagnosa!,
            style: AppTextStyle.caption
                .withColor(colorScheme.onSurface)
                .withWeight(AppFontWeight.medium),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailLabModel detailLab,
  ) {
    final totalTests = detailLab.labResultsCount;
    final normalTests =
        detailLab.detailDataLab?.where((r) => r.isNormal == true).length ?? 0;
    final abnormalTests =
        detailLab.detailDataLab?.where((r) => r.isNormal == false).length ?? 0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            Icons.analytics_outlined,
            totalTests.toString(),
            l10n.labTestResults,
            colorScheme.primary,
            colorScheme,
          ),
        ),
        SizedBox(width: AppSizes.spacingSmall),
        Expanded(
          child: _buildStatCard(
            Icons.check_circle_outline,
            normalTests.toString(),
            'Normal',
            AppColor.green,
            colorScheme,
          ),
        ),
        SizedBox(width: AppSizes.spacingSmall),
        Expanded(
          child: _buildStatCard(
            Icons.warning_amber_rounded,
            abnormalTests.toString(),
            'Abnormal',
            AppColor.orange,
            colorScheme,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color color,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: color.withAlpha(13),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: color.withAlpha(51), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          SizedBox(height: AppSizes.spacingTiny),
          Text(
            value,
            style: AppTextStyle.subtitle
                .withColor(color)
                .withWeight(AppFontWeight.bold),
          ),
          Text(
            label,
            style: AppTextStyle.supportText.withColor(
              colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation(ColorScheme colorScheme, AppLocalizations l10n) {
    return Row(
      children: [
        _buildTabButton('Results Table', 0, colorScheme),
        SizedBox(width: AppSizes.spacingSmall),
        _buildTabButton('Analysis', 1, colorScheme),
      ],
    );
  }

  Widget _buildTabButton(String title, int index, ColorScheme colorScheme) {
    final isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLarge,
          vertical: AppSizes.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withAlpha(51),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
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

  Widget _buildResultsTab(
      ColorScheme colorScheme,
      AppLocalizations l10n,
      DetailLabModel detailLab,
      ) {
    if (!detailLab.hasLabResults) {
      return _buildEmptyState(colorScheme, l10n);
    }

    return ListView(
      primary: false,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(
        top: AppSizes.spacingMedium,
        left: AppSizes.paddingLarge,
        right: AppSizes.paddingLarge,
        bottom: 0,
      ),
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            border: Border.all(color: colorScheme.surfaceContainerHighest, width: 1),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withAlpha(13),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: _buildDataTable(colorScheme, l10n, detailLab),
        ),
      ],
    );
  }

  Widget _buildDataTable(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailLabModel detailLab,
  ) {
    final results = detailLab.detailDataLab!;

    // total lebar tabel
    const double tableWidth = 1200.0;

    // rasio kolom (total = 1.0)
    const ratios = {
      'no': 0.05,
      'category': 0.15,
      'name': 0.20,
      'result': 0.10,
      'unit': 0.08,
      'range': 0.12,
      'status': 0.10,
      'notes': 0.20,
    };

    double w(String key) => tableWidth * ratios[key]!;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _horizontalScrollController,
          child: SizedBox(
            width: tableWidth > constraints.maxWidth
                ? tableWidth
                : constraints.maxWidth,
            child: Column(
              children: [
                // HEADER
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary,
                        colorScheme.primary.withAlpha(230),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildTableHeader('No', w('no'), colorScheme, true),
                      _buildTableHeader(
                        'Category',
                        w('category'),
                        colorScheme,
                        true,
                      ),
                      _buildTableHeader(
                        'Test Name',
                        w('name'),
                        colorScheme,
                        true,
                      ),
                      _buildTableHeader(
                        'Result',
                        w('result'),
                        colorScheme,
                        true,
                      ),
                      _buildTableHeader('Unit', w('unit'), colorScheme, true),
                      _buildTableHeader(
                        'Normal Range',
                        w('range'),
                        colorScheme,
                        true,
                      ),
                      _buildTableHeader(
                        'Status',
                        w('status'),
                        colorScheme,
                        true,
                      ),
                      _buildTableHeader('Notes', w('notes'), colorScheme, true),
                    ],
                  ),
                ),

                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final r = results[index];
                      final isEven = index % 2 == 0;

                      return Container(
                        decoration: BoxDecoration(
                          color: isEven
                              ? colorScheme.surface
                              : colorScheme.surfaceContainerHighest.withAlpha(
                                  32,
                                ),
                          border: Border(
                            bottom: BorderSide(
                              color: colorScheme.surfaceContainerHighest,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildTableCell(
                              (index + 1).toString(),
                              w('no'),
                              colorScheme,
                            ),
                            _buildTableCell(
                              r.subName,
                              w('category'),
                              colorScheme,
                            ),
                            _buildTableCell(
                              r.item,
                              w('name'),
                              colorScheme,
                              isHighlight: true,
                            ),
                            _buildTableCell(
                              r.formattedResult,
                              w('result'),
                              colorScheme,
                              color: r.getStatusColor(),
                              isBold: true,
                            ),
                            _buildTableCell(r.satuan, w('unit'), colorScheme),
                            _buildTableCell(
                              r.normalValue,
                              w('range'),
                              colorScheme,
                            ),
                            _buildStatusCell(r, colorScheme, w('status')),
                            _buildTableCell(
                              r.keterangan,
                              w('notes'),
                              colorScheme,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTableHeader(
    String title,
    double width,
    ColorScheme colorScheme,
    bool isHeader,
  ) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingMedium,
      ),
      child: Text(
        title,
        style: AppTextStyle.caption
            .withColor(colorScheme.onPrimary)
            .withWeight(AppFontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(
    String text,
    double width,
    ColorScheme colorScheme, {
    TextAlign alignment = TextAlign.center,
    Color? color,
    bool isBold = false,
    bool isHighlight = false,
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingMedium,
      ),
      child: Text(
        text,
        style: AppTextStyle.caption
            .withColor(
              color ??
                  (isHighlight
                      ? colorScheme.onSurface
                      : colorScheme.onSurface.withAlpha(204)),
            )
            .withWeight(
              isBold || isHighlight
                  ? AppFontWeight.medium
                  : AppFontWeight.regular,
            ),
        textAlign: alignment,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStatusCell(
    DetailDataLabModel result,
    ColorScheme colorScheme,
    double width,
  ) {
    final isNormal = result.isNormal;
    final statusColor = result.getStatusColor();
    final statusText = result.getStatusText();

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall,
        vertical: AppSizes.paddingMedium,
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingSmall,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: statusColor?.withAlpha(26) ?? Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
            border: Border.all(
              color: statusColor?.withAlpha(51) ?? Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isNormal != null) ...[
                Icon(
                  isNormal ? Icons.check_circle : Icons.warning,
                  size: 12,
                  color: statusColor,
                ),
                SizedBox(width: 4),
              ],
              Text(
                statusText,
                style: AppTextStyle.supportText.withColor(
                  statusColor ?? colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisTab(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    DetailLabModel detailLab,
  ) {
    if (!detailLab.hasLabResults) {
      return _buildEmptyState(colorScheme, l10n);
    }

    // Group results by category
    final groupedResults = <String, List<DetailDataLabModel>>{};
    for (final result in detailLab.detailDataLab!) {
      groupedResults.putIfAbsent(result.subName, () => []).add(result);
    }

    return ListView.builder(
      primary: false,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppSizes.paddingLarge,
        right: AppSizes.paddingLarge,
        bottom: AppSizes.spacingXl,
      ),
      itemCount: groupedResults.length,
      itemBuilder: (context, index) {
        final category = groupedResults.keys.elementAt(index);
        final results = groupedResults[category]!;

        return Container(
          margin: EdgeInsets.only(bottom: AppSizes.spacingMedium),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            border: Border.all(
              color: colorScheme.surfaceContainerHighest,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withAlpha(8),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLarge,
                vertical: AppSizes.paddingSmall,
              ),
              leading: Container(
                padding: EdgeInsets.all(AppSizes.paddingSmall),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(26),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
                child: Icon(
                  Icons.category_outlined,
                  size: 20,
                  color: colorScheme.primary,
                ),
              ),
              title: Text(
                category,
                style: AppTextStyle.subtitle
                    .withColor(colorScheme.onSurface)
                    .withWeight(AppFontWeight.bold),
              ),
              subtitle: Text(
                '${results.length} tests',
                style: AppTextStyle.caption.withColor(
                  colorScheme.onSurface.withAlpha(128),
                ),
              ),
              trailing: _buildCategoryStatus(results, colorScheme),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(AppSizes.radiusMedium),
                    ),
                  ),
                  child: Column(
                    children: results.map((result) {
                      return _buildAnalysisItem(
                        result,
                        colorScheme,
                        l10n,
                        isLast: result == results.last,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryStatus(
    List<DetailDataLabModel> results,
    ColorScheme colorScheme,
  ) {
    final hasAbnormal = results.any((r) => r.isNormal == false);
    final color = hasAbnormal ? AppColor.orange : AppColor.green;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: AppSizes.spacingTiny),
          Text(
            hasAbnormal ? 'Review' : 'Normal',
            style: AppTextStyle.supportText.withColor(color),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(
    DetailDataLabModel result,
    ColorScheme colorScheme,
    AppLocalizations l10n, {
    bool isLast = false,
  }) {
    final statusColor = result.getStatusColor();

    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: colorScheme.surfaceContainerHighest.withAlpha(64),
                  width: 0.5,
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Test Name and Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.item,
                      style: AppTextStyle.subtitle
                          .withColor(colorScheme.onSurface)
                          .withWeight(AppFontWeight.medium),
                    ),
                    if (result.keterangan != '-')
                      Padding(
                        padding: EdgeInsets.only(top: AppSizes.spacingTiny),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 14,
                              color: colorScheme.onSurface.withAlpha(128),
                            ),
                            SizedBox(width: AppSizes.spacingTiny),
                            Expanded(
                              child: Text(
                                result.keterangan,
                                style: AppTextStyle.supportText.withColor(
                                  colorScheme.onSurface.withAlpha(179),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (result.isNormal != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        statusColor!.withAlpha(26),
                        statusColor.withAlpha(13),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    border: Border.all(
                      color: statusColor.withAlpha(51),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        result.isNormal!
                            ? Icons.check_circle_rounded
                            : Icons.warning_rounded,
                        size: 14,
                        color: statusColor,
                      ),
                      SizedBox(width: AppSizes.spacingTiny),
                      Text(
                        result.getStatusText(),
                        style: AppTextStyle.supportText
                            .withColor(statusColor)
                            .withWeight(AppFontWeight.medium),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          SizedBox(height: AppSizes.spacingMedium),

          // Result Cards
          Row(
            children: [
              // Result Value Card
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(AppSizes.paddingMedium),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary.withAlpha(8),
                        colorScheme.primary.withAlpha(13),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    border: Border.all(
                      color:
                          statusColor?.withAlpha(51) ??
                          colorScheme.surfaceContainerHighest,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.science_outlined,
                            size: 14,
                            color: colorScheme.onSurface.withAlpha(128),
                          ),
                          SizedBox(width: AppSizes.spacingTiny),
                          Text(
                            l10n.labResult,
                            style: AppTextStyle.supportText.withColor(
                              colorScheme.onSurface.withAlpha(128),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spacingTiny),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            result.result,
                            style: AppTextStyle.title
                                .withColor(statusColor ?? colorScheme.onSurface)
                                .withWeight(AppFontWeight.bold),
                          ),
                          SizedBox(width: AppSizes.spacingTiny),
                          Text(
                            result.satuan,
                            style: AppTextStyle.caption.withColor(
                              colorScheme.onSurface.withAlpha(179),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: AppSizes.spacingSmall),

              // Normal Range Card
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(AppSizes.paddingMedium),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withAlpha(32),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    border: Border.all(
                      color: colorScheme.surfaceContainerHighest,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.speed_outlined,
                            size: 14,
                            color: colorScheme.onSurface.withAlpha(128),
                          ),
                          SizedBox(width: AppSizes.spacingTiny),
                          Text(
                            l10n.labNormalRange,
                            style: AppTextStyle.supportText.withColor(
                              colorScheme.onSurface.withAlpha(128),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spacingTiny),
                      Text(
                        result.normalValue,
                        style: AppTextStyle.subtitle
                            .withColor(colorScheme.onSurface)
                            .withWeight(AppFontWeight.medium),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Visual Indicator Bar
          if (result.isNormal != null) ...[
            SizedBox(height: AppSizes.spacingMedium),
            _buildRangeIndicator(result, colorScheme),
          ],
        ],
      ),
    );
  }

  Widget _buildRangeIndicator(
    DetailDataLabModel result,
    ColorScheme colorScheme,
  ) {
    // This is a visual representation of where the result falls in the normal range
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(32),
        borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
      ),
      child: Row(
        children: [
          Icon(
            Icons.trending_flat,
            size: 16,
            color: colorScheme.onSurface.withAlpha(128),
          ),
          SizedBox(width: AppSizes.spacingSmall),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background bar
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.orange.withAlpha(128),
                        AppColor.green.withAlpha(128),
                        AppColor.green.withAlpha(128),
                        AppColor.orange.withAlpha(128),
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Indicator
                if (result.isNormal!)
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColor.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.green.withAlpha(51),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColor.orange,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.orange.withAlpha(51),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AppSizes.spacingLarge),
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(13),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.science_outlined,
              size: 64,
              color: colorScheme.primary.withAlpha(128),
            ),
          ),
          SizedBox(height: AppSizes.spacingLarge),
          Text(
            l10n.noLabResults,
            style: AppTextStyle.title.withColor(colorScheme.onSurface),
          ),
          SizedBox(height: AppSizes.spacingSmall),
          Text(
            l10n.noLabResultsDesc,
            style: AppTextStyle.caption.withColor(
              colorScheme.onSurface.withAlpha(128),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
