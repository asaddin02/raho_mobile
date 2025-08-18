import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/dashboard.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/presentation/dashboard/states/dashboard/dashboard_bloc.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(LoadDashboardData()),
      child: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCheckRequested());
    // Load dashboard data saat init
    context.read<DashboardBloc>().add(LoadDashboardData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<DashboardBloc>().add(RefreshDashboardData());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: AppSizes.spacingXxl + AppSizes.paddingLarge,
              right: AppSizes.paddingLarge,
              left: AppSizes.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.dashboardWelcome,
                      style: AppTextStyle.body.withColor(
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.paddingTiny,
                        horizontal: AppSizes.paddingLarge,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusMedium,
                        ),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spacingTiny),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final user = context.read<AuthBloc>().currentUser;

                    return Text(
                      user?.name ?? '',
                      style: AppTextStyle.title.withColor(
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.spacingLarge),

                // Voucher Section - Dynamic from API
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    return _buildVoucherCard(context, state);
                  },
                ),

                SizedBox(height: AppSizes.spacingLarge),
                GestureDetector(
                  onTap: () {
                    context.goNamed(AppRoutes.therapy.name);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.dashboardLastTherapy,
                        style: AppTextStyle.subtitle
                            .withColor(Theme.of(context).colorScheme.onSurface)
                            .withWeight(AppFontWeight.semiBold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        size: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.spacingMedium),

                // Therapy History Section - Dynamic from API
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    return _buildTherapyHistorySection(context, state, l10n);
                  },
                ),

                SizedBox(height: AppSizes.spacingLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.dashboardEventPromo,
                      style: AppTextStyle.subtitle
                          .withColor(Theme.of(context).colorScheme.onSurface)
                          .withWeight(AppFontWeight.semiBold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 16,
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spacingMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherCard(BuildContext context, DashboardState state) {
    Widget content;

    if (state is DashboardLoading) {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              CupertinoIcons.tickets_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
          const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
          Container(
            height: 60,
            width: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ],
      );
    } else if (state is DashboardSuccess) {
      final voucher = state.data.voucher;
      final l10n = AppLocalizations.of(context)!;

      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              CupertinoIcons.tickets_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.dashboardYourVoucher,
                style: AppTextStyle.caption.withColor(
                  Colors.white.withValues(alpha: 0.9),
                ),
              ),
              SizedBox(height: AppSizes.spacingTiny),
              Text(
                voucher.voucherBalance.toInt().toString(),
                style: AppTextStyle.title
                    .withColor(Colors.white)
                    .withWeight(AppFontWeight.bold),
              ),
            ],
          ),
          Container(
            height: 60,
            width: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.dashboardUsedVoucher,
                style: AppTextStyle.caption.withColor(
                  Colors.white.withValues(alpha: 0.9),
                ),
              ),
              SizedBox(height: AppSizes.spacingTiny),
              Text(
                voucher.voucherUsedThisMonth.toInt().toString(),
                style: AppTextStyle.title
                    .withColor(Colors.white)
                    .withWeight(AppFontWeight.bold),
              ),
            ],
          ),
        ],
      );
    } else if (state is DashboardRefreshing) {
      final voucher = state.previousData.voucher;
      final l10n = AppLocalizations.of(context)!;

      content = Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  color: Colors.white.withValues(alpha: 0.2),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.tickets_fill,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l10n.dashboardYourVoucher,
                    style: AppTextStyle.caption.withColor(
                      Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingTiny),
                  Text(
                    voucher.voucherBalance.toInt().toString(),
                    style: AppTextStyle.title
                        .withColor(Colors.white)
                        .withWeight(AppFontWeight.bold),
                  ),
                ],
              ),
              Container(
                height: 60,
                width: 1,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l10n.dashboardUsedVoucher,
                    style: AppTextStyle.caption.withColor(
                      Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingTiny),
                  Text(
                    voucher.voucherUsedThisMonth.toInt().toString(),
                    style: AppTextStyle.title
                        .withColor(Colors.white)
                        .withWeight(AppFontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      );
    } else {
      final l10n = AppLocalizations.of(context)!;
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              CupertinoIcons.tickets_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.dashboardYourVoucher,
                style: AppTextStyle.caption.withColor(
                  Colors.white.withValues(alpha: 0.9),
                ),
              ),
              SizedBox(height: AppSizes.spacingTiny),
              Text(
                "-",
                style: AppTextStyle.title
                    .withColor(Colors.white)
                    .withWeight(AppFontWeight.bold),
              ),
            ],
          ),
          Container(
            height: 60,
            width: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.dashboardUsedVoucher,
                style: AppTextStyle.caption.withColor(
                  Colors.white.withValues(alpha: 0.9),
                ),
              ),
              SizedBox(height: AppSizes.spacingTiny),
              Text(
                "-",
                style: AppTextStyle.title
                    .withColor(Colors.white)
                    .withWeight(AppFontWeight.bold),
              ),
            ],
          ),
        ],
      );
    }

    return Container(
      height: 120,
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: content,
    );
  }

  Widget _buildTherapyHistorySection(
    BuildContext context,
    DashboardState state,
    AppLocalizations l10n,
  ) {
    if (state is DashboardLoading) {
      return Column(
        children: [
          _buildSkeletonTherapyCard(context),
          SizedBox(height: AppSizes.spacingSmall),
          _buildSkeletonTherapyCard(context),
        ],
      );
    }

    if (state is DashboardSuccess) {
      final history = state.data.history;

      if (history.isEmpty) {
        return Container(
          height: 100,
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              l10n.therapyEmptyTitle,
              style: AppTextStyle.caption.withColor(
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
        );
      }

      return Column(
        children: history
            .map(
              (historyItem) => Column(
                children: [
                  _buildTherapyCard(context, historyItem),
                  if (historyItem != history.last)
                    SizedBox(height: AppSizes.spacingSmall),
                ],
              ),
            )
            .toList(),
      );
    }

    if (state is DashboardRefreshing) {
      final history = state.previousData.history;

      return Column(
        children: history
            .map(
              (historyItem) => Column(
                children: [
                  _buildTherapyCard(context, historyItem),
                  if (historyItem != history.last)
                    SizedBox(height: AppSizes.spacingSmall),
                ],
              ),
            )
            .toList(),
      );
    }

    if (state is DashboardError) {
      return Container(
        height: 100,
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            l10n.genericError,
            style: AppTextStyle.caption.withColor(
              Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      );
    }

    // Error state
    return Container(
      height: 100,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          l10n.therapyLoadingError,
          style: AppTextStyle.caption.withColor(
            Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }

  Widget _buildTherapyCard(BuildContext context, HistoryItem historyItem) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        context.goNamed(
          AppRoutes.detailTherapy.name,
          pathParameters: {'id': historyItem.id.toString()},
        );
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
              child: Icon(
                FontAwesomeIcons.syringe,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 28,
              ),
            ),
            SizedBox(width: AppSizes.spacingSmall),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    historyItem.nameProduct,
                    style: AppTextStyle.caption
                        .withColor(Theme.of(context).colorScheme.onSurface)
                        .withWeight(AppFontWeight.semiBold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            historyItem.companyName,
                            style: AppTextStyle.caption.withColor(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: AppSizes.spacingTiny),
                          Text(
                            historyItem.date,
                            style: AppTextStyle.supportText
                                .withColor(
                                  Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                )
                                .withWeight(AppFontWeight.medium),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            l10n.dashboardTherapyInfusionNumber(
                              historyItem.infus.toString(),
                            ),
                            style: AppTextStyle.caption.withColor(
                              Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: AppSizes.spacingTiny),
                          Text(
                            historyItem.nakes,
                            style: AppTextStyle.supportText
                                .withColor(
                                  Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                )
                                .withWeight(AppFontWeight.medium),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonTherapyCard(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
          ),
          SizedBox(width: AppSizes.spacingSmall),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: AppSizes.spacingTiny),
                        Container(
                          height: 12,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 12,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: AppSizes.spacingTiny),
                        Container(
                          height: 12,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
