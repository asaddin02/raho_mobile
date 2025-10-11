import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
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
      child: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentEventIndex = 0;

  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCheckRequested());
    context.read<DashboardBloc>().add(LoadDashboardData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

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
                      style: AppTextStyle.body.withColor(scheme.onSurface),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spacingTiny),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final user = context.read<AuthBloc>().currentUser;
                    return Text(
                      user?.name ?? '',
                      style: AppTextStyle.title.withColor(scheme.onSurface),
                    );
                  },
                ),
                SizedBox(height: AppSizes.spacingLarge),

                // Voucher Section
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    return _buildVoucherCard(context, state);
                  },
                ),

                SizedBox(height: AppSizes.spacingLarge),

                // Therapy History Header
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
                            .withColor(scheme.onSurface)
                            .withWeight(AppFontWeight.semiBold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: scheme.onSurface.withValues(alpha: 0.7),
                        size: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.spacingMedium),

                // Therapy History Section
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    return _buildTherapyHistorySection(context, state, l10n);
                  },
                ),

                SizedBox(height: AppSizes.spacingLarge),

                // Event Promo Header
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.eventList.name);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.dashboardEventPromo,
                        style: AppTextStyle.subtitle
                            .withColor(scheme.onSurface)
                            .withWeight(AppFontWeight.semiBold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: scheme.onSurface.withValues(alpha: 0.7),
                        size: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.spacingMedium),

                // Event Carousel Section
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    return _buildEventCarousel(context, state, l10n);
                  },
                ),

                SizedBox(height: AppSizes.spacingXl),
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
          Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
          Container(
            height: 60,
            width: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      );
    } else if (state is DashboardSuccess) {
      final voucher = state.data.voucher;
      final l10n = AppLocalizations.of(context)!;

      content = Row(
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
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.dashboardYourVoucher,
                  style: AppTextStyle.caption.withColor(
                    Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.spacingTiny),
                Text(
                  voucher.voucherBalance.isNaN
                      ? "0"
                      : voucher.voucherBalance.toInt().toString(),
                  style: AppTextStyle.title
                      .withColor(Colors.white)
                      .withWeight(AppFontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            width: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.dashboardUsedVoucher,
                  style: AppTextStyle.caption.withColor(
                    Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.spacingTiny),
                Text(
                  voucher.voucherUsedThisMonth.isNaN
                      ? "0"
                      : voucher.voucherUsedThisMonth.toInt().toString(),
                  style: AppTextStyle.title
                      .withColor(Colors.white)
                      .withWeight(AppFontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      );
    } else if (state is DashboardRefreshing) {
      final voucher = state.previousData.voucher;
      final l10n = AppLocalizations.of(context)!;

      content = Stack(
        children: [
          Row(
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
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.dashboardYourVoucher,
                      style: AppTextStyle.caption.withColor(
                        Colors.white.withValues(alpha: 0.9),
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: AppSizes.spacingTiny),
                    Text(
                      voucher.voucherBalance.toInt().toString(),
                      style: AppTextStyle.title
                          .withColor(Colors.white)
                          .withWeight(AppFontWeight.bold),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: 1,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.dashboardUsedVoucher,
                      style: AppTextStyle.caption.withColor(
                        Colors.white.withValues(alpha: 0.9),
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: AppSizes.spacingTiny),
                    Text(
                      voucher.voucherUsedThisMonth.toInt().toString(),
                      style: AppTextStyle.title
                          .withColor(Colors.white)
                          .withWeight(AppFontWeight.bold),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
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
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.dashboardYourVoucher,
                  style: AppTextStyle.caption.withColor(
                    Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.spacingTiny),
                Text(
                  "-",
                  style: AppTextStyle.title
                      .withColor(Colors.white)
                      .withWeight(AppFontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            width: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.dashboardUsedVoucher,
                  style: AppTextStyle.caption.withColor(
                    Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.spacingTiny),
                Text(
                  "-",
                  style: AppTextStyle.title
                      .withColor(Colors.white)
                      .withWeight(AppFontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
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
    final scheme = Theme.of(context).colorScheme;

    if (state is DashboardLoading) {
      return Column(
        children: [
          _buildSkeletonTherapyCard(context),
          SizedBox(height: AppSizes.spacingSmall),
          _buildSkeletonTherapyCard(context),
        ],
      );
    }

    if (state is DashboardSuccess || state is DashboardRefreshing) {
      final history = state is DashboardSuccess
          ? state.data.history
          : (state as DashboardRefreshing).previousData.history;

      if (history.isEmpty) {
        return Container(
          height: 100,
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            color: scheme.surface,
            border: Border.all(
              color: scheme.onSurface.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              l10n.therapyEmptyTitle,
              style: AppTextStyle.caption.withColor(
                scheme.onSurface.withValues(alpha: 0.7),
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

    // Error state
    return Container(
      height: 100,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        color: scheme.surface,
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          l10n.genericError,
          style: AppTextStyle.caption.withColor(scheme.error),
        ),
      ),
    );
  }

  Widget _buildTherapyCard(BuildContext context, HistoryItem historyItem) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

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
          color: scheme.surface,
          border: Border.all(
            color: scheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: scheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
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
                color: scheme.primary,
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
              child: Icon(
                FontAwesomeIcons.syringe,
                color: scheme.onPrimary,
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
                        .withColor(scheme.onSurface)
                        .withWeight(AppFontWeight.semiBold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              historyItem.companyName,
                              style: AppTextStyle.caption.withColor(
                                scheme.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: AppSizes.spacingTiny),
                            Text(
                              historyItem.date,
                              style: AppTextStyle.supportText
                                  .withColor(
                                    scheme.onSurface.withValues(alpha: 0.7),
                                  )
                                  .withWeight(AppFontWeight.medium),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppSizes.spacingSmall),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            l10n.dashboardTherapyInfusionNumber(
                              historyItem.infus.toString(),
                            ),
                            style: AppTextStyle.caption.withColor(
                              scheme.onSurface,
                            ),
                          ),
                          SizedBox(height: AppSizes.spacingTiny),
                          Text(
                            historyItem.nakes,
                            style: AppTextStyle.supportText
                                .withColor(
                                  scheme.onSurface.withValues(alpha: 0.7),
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
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 100,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        color: scheme.surface,
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: scheme.onSurface.withValues(alpha: 0.1),
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
                    color: scheme.onSurface.withValues(alpha: 0.1),
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
                            color: scheme.onSurface.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: AppSizes.spacingTiny),
                        Container(
                          height: 12,
                          width: 60,
                          decoration: BoxDecoration(
                            color: scheme.onSurface.withValues(alpha: 0.1),
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
                            color: scheme.onSurface.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: AppSizes.spacingTiny),
                        Container(
                          height: 12,
                          width: 70,
                          decoration: BoxDecoration(
                            color: scheme.onSurface.withValues(alpha: 0.1),
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

  Widget _buildEventCarousel(
    BuildContext context,
    DashboardState state,
    AppLocalizations l10n,
  ) {
    final scheme = Theme.of(context).colorScheme;

    if (state is DashboardLoading) {
      return _buildSkeletonEventCarousel(context);
    }

    if (state is DashboardSuccess || state is DashboardRefreshing) {
      final events = state is DashboardSuccess
          ? state.data.event
          : (state as DashboardRefreshing).previousData.event;

      if (events.isEmpty) {
        return Container(
          height: 180,
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            color: scheme.surface,
            border: Border.all(
              color: scheme.onSurface.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 48,
                  color: scheme.onSurface.withValues(alpha: 0.3),
                ),
                SizedBox(height: AppSizes.spacingSmall),
                Text(
                  l10n.noEventsAvailable,
                  style: AppTextStyle.caption.withColor(
                    scheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: events.length,
            itemBuilder: (context, index, realIndex) {
              final event = events[index];
              return _buildEventCard(context, event);
            },
            options: CarouselOptions(
              height: 180,
              viewportFraction: 0.9,
              enableInfiniteScroll: events.length > 1,
              autoPlay: events.length > 1,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentEventIndex = index;
                });
              },
            ),
          ),
          if (events.length > 1) ...[
            SizedBox(height: AppSizes.spacingSmall),
            _buildEventIndicators(events.length),
          ],
        ],
      );
    }

    // Error state
    return Container(
      height: 180,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        color: scheme.surface,
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          l10n.eventLoadingError,
          style: AppTextStyle.caption.withColor(scheme.error),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, EventItem event) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.eventDetail.name,
          pathParameters: {'id': event.id.toString()},
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.marginTiny),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              if (event.banner != null)
                Image.memory(
                  base64Decode(utf8.decode(base64Decode(event.banner!))),
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) => Container(
                    color: scheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.event,
                      size: 48,
                      color: scheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [scheme.primary, scheme.secondary],
                    ),
                  ),
                ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      scheme.onSurface.withValues(alpha: 0.8),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: AppSizes.paddingMedium,
                left: AppSizes.paddingMedium,
                right: AppSizes.paddingMedium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.name,
                      style: AppTextStyle.subtitle
                          .withColor(scheme.onPrimary)
                          .withWeight(AppFontWeight.semiBold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSizes.spacingTiny),
                    Text(
                      event.description,
                      style: AppTextStyle.caption.withColor(
                        scheme.onPrimary.withValues(alpha: 0.9),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSizes.spacingTiny),
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 14,
                          color: scheme.onPrimary.withValues(alpha: 0.9),
                        ),
                        SizedBox(width: AppSizes.paddingTiny),
                        Text(
                          event.participantDisplay,
                          style: AppTextStyle.supportText.withColor(
                            scheme.onPrimary.withValues(alpha: 0.9),
                          ),
                        ),
                        SizedBox(width: AppSizes.spacingSmall),
                        if (event.location != null) ...[
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: scheme.onPrimary.withValues(alpha: 0.9),
                          ),
                          SizedBox(width: AppSizes.paddingTiny),
                          Expanded(
                            child: Text(
                              event.location!,
                              style: AppTextStyle.supportText.withColor(
                                scheme.onPrimary.withValues(alpha: 0.9),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Badge if event is full
              if (event.isFull)
                Positioned(
                  top: AppSizes.paddingMedium,
                  right: AppSizes.paddingMedium,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingSmall,
                      vertical: AppSizes.paddingTiny,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.errorContainer,
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                    child: Text(
                      l10n.eventFull,
                      style: AppTextStyle.supportText
                          .withColor(scheme.onErrorContainer)
                          .withWeight(AppFontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventIndicators(int count) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          width: _currentEventIndex == index ? 24 : 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: AppSizes.marginTiny),
          decoration: BoxDecoration(
            color: _currentEventIndex == index
                ? scheme.primary
                : scheme.onSurface.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonEventCarousel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.marginTiny),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: scheme.primary),
      ),
    );
  }
}
