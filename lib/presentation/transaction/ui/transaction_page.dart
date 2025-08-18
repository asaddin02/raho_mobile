import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/data/models/transaction.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/presentation/transaction/states/transaction/transaction_bloc.dart';
import 'package:raho_member_apps/presentation/widgets/filter_dropdown.dart';

class TransactionPageWrapper extends StatelessWidget {
  const TransactionPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TransactionBloc>(),
      child: const TransactionPage(),
    );
  }
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final ScrollController _paymentScrollController = ScrollController();
  final ScrollController _fakturScrollController = ScrollController();
  final GlobalKey _paymentHeaderKey = GlobalKey();
  final GlobalKey _fakturHeaderKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _setupScrollListeners();
  }

  @override
  void dispose() {
    _paymentScrollController.dispose();
    _fakturScrollController.dispose();
    super.dispose();
  }

  void _setupScrollListeners() {
    _paymentScrollController.addListener(() {
      if (_isBottomReached(_paymentScrollController)) {
        final state = context.read<TransactionBloc>().state;
        if (state is TransactionLoaded &&
            !state.paymentHasReachedMax &&
            !state.paymentLoading) {
          bool shouldLoadMore = false;

          if (state.transactionType == TransactionType.payment) {
            shouldLoadMore = true;
          } else if (state.transactionType == TransactionType.all &&
              state.expandedSection == ExpandedSection.payment) {
            shouldLoadMore = true;
          }

          if (shouldLoadMore) {
            context.read<TransactionBloc>().add(
              LoadMorePaymentEvent(filters: state.activeFilters),
            );
          }
        }
      }
    });

    _fakturScrollController.addListener(() {
      if (_isBottomReached(_fakturScrollController)) {
        final state = context.read<TransactionBloc>().state;
        if (state is TransactionLoaded &&
            !state.fakturHasReachedMax &&
            !state.fakturLoading) {
          bool shouldLoadMore = false;

          if (state.transactionType == TransactionType.service) {
            shouldLoadMore = true;
          } else if (state.transactionType == TransactionType.all &&
              state.expandedSection == ExpandedSection.faktur) {
            shouldLoadMore = true;
          }

          if (shouldLoadMore) {
            context.read<TransactionBloc>().add(
              LoadMoreFakturEvent(filters: state.activeFilters),
            );
          }
        }
      }
    });
  }

  bool _isBottomReached(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _loadInitialData() {
    context.read<TransactionBloc>().add(const FetchInitialTransactionEvent());
  }

  void _onDateFilterChanged(String value, AppLocalizations l10n) {
    int? days;

    if (value == l10n.voucherDateToday) {
      days = 1;
    } else if (value == l10n.voucherDate7Days) {
      days = 7;
    } else if (value == l10n.voucherDate30Days) {
      days = 30;
    } else if (value == l10n.voucherDate60Days) {
      days = 60;
    } else if (value == l10n.voucherDate90Days) {
      days = 90;
    }

    context.read<TransactionBloc>().add(
      FilterTransactionByDaysEvent(days: days),
    );
  }

  void _togglePaymentSection() {
    final state = context.read<TransactionBloc>().state;
    if (state is TransactionLoaded) {
      if (state.transactionType == TransactionType.all) {
        if (state.expandedSection == ExpandedSection.payment) {
          context.read<TransactionBloc>().add(CollapseSectionEvent());
        } else {
          context.read<TransactionBloc>().add(ExpandPaymentSectionEvent());
          _scrollToSection(_paymentHeaderKey);
        }
      }
    }
  }

  void _toggleFakturSection() {
    final state = context.read<TransactionBloc>().state;
    if (state is TransactionLoaded) {
      if (state.transactionType == TransactionType.all) {
        if (state.expandedSection == ExpandedSection.faktur) {
          context.read<TransactionBloc>().add(CollapseSectionEvent());
        } else {
          context.read<TransactionBloc>().add(ExpandFakturSectionEvent());
          _scrollToSection(_fakturHeaderKey);
        }
      }
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSizes.paddingLarge,
                AppSizes.spacingLarge,
                AppSizes.paddingLarge,
                AppSizes.spacingMedium,
              ),
              child: Text(
                l10n.transactionDetailTitle,
                style: AppTextStyle.title.withColor(colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
            ),
            _buildFilterSection(colorScheme, l10n),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TransactionError) {
                    return _buildErrorState(state, colorScheme, l10n);
                  }

                  if (state is TransactionLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<TransactionBloc>().add(
                          RefreshTransactionEvent(filters: state.activeFilters),
                        );
                      },
                      child: _buildOptimizedTransactionList(
                        state,
                        colorScheme,
                        l10n,
                      ),
                    );
                  }

                  return Center(
                    child: Text(
                      l10n.noDataAvailable,
                      style: AppTextStyle.body.withColor(colorScheme.onSurface),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(ColorScheme colorScheme, AppLocalizations l10n) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.paddingMedium,
        horizontal: AppSizes.paddingLarge,
      ),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                return FilterDropdown(
                  icon: Icons.local_offer_outlined,
                  label: l10n.transactionFilterLabel,
                  items: [
                    l10n.transactionFilterAll,
                    l10n.transactionFilterPayment,
                    l10n.transactionFilterService,
                  ],
                  onSelect: (value) {
                    TransactionType transactionType;
                    if (value == l10n.transactionFilterPayment) {
                      transactionType = TransactionType.payment;
                    } else if (value == l10n.transactionFilterService) {
                      transactionType = TransactionType.service;
                    } else {
                      transactionType = TransactionType.all;
                    }

                    context.read<TransactionBloc>().add(
                      FilterTransactionByTypeEvent(
                        transactionType: transactionType,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(width: AppSizes.spacingMedium),
          Expanded(
            child: FilterDropdown(
              icon: Icons.calendar_today_outlined,
              label: l10n.voucherFilterDate,
              items: [
                l10n.voucherDateAll,
                l10n.voucherDateToday,
                l10n.voucherDate7Days,
                l10n.voucherDate30Days,
                l10n.voucherDate60Days,
                l10n.voucherDate90Days,
              ],
              onSelect: (value) => _onDateFilterChanged(value, l10n),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizedTransactionList(
    TransactionLoaded state,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    final hasPaymentsToShow =
        state.shouldShowPayments && state.allPayments.isNotEmpty;
    final hasFaktursToShow =
        state.shouldShowFakturs && state.allFakturs.isNotEmpty;

    if (!hasPaymentsToShow && !hasFaktursToShow) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            SizedBox(height: AppSizes.spacingMedium),
            Text(
              _getEmptyMessage(state.transactionType, l10n),
              style: AppTextStyle.body.withColor(
                colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state.expandedSection == ExpandedSection.payment && hasPaymentsToShow) {
      return _buildExpandedPaymentView(state, colorScheme, l10n);
    } else if (state.expandedSection == ExpandedSection.faktur &&
        hasFaktursToShow) {
      return _buildExpandedFakturView(state, colorScheme, l10n);
    } else {
      return _buildCollapsedView(state, colorScheme, l10n);
    }
  }

  Widget _buildCollapsedView(
    TransactionLoaded state,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return ListView(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      children: [
        if (state.shouldShowPayments && state.allPayments.isNotEmpty) ...[
          _buildSectionHeader(
            key: _paymentHeaderKey,
            title: l10n.transactionStatusPaid,
            onTap: state.canExpandPayment ? _togglePaymentSection : null,
            colorScheme: colorScheme,
            showArrow: state.canExpandPayment,
          ),
          SizedBox(height: AppSizes.spacingMedium),
          ...state.paymentsToDisplay.map(
            (payment) => _buildPaymentItem(payment, colorScheme, l10n),
          ),
        ],

        if (state.shouldShowPayments &&
            state.allPayments.isNotEmpty &&
            state.shouldShowFakturs &&
            state.allFakturs.isNotEmpty)
          SizedBox(height: AppSizes.spacingXl),
        if (state.shouldShowFakturs && state.allFakturs.isNotEmpty) ...[
          _buildSectionHeader(
            key: _fakturHeaderKey,
            title: l10n.transactionTherapyDone,
            onTap: state.canExpandFaktur ? _toggleFakturSection : null,
            colorScheme: colorScheme,
            showArrow: state.canExpandFaktur,
          ),
          SizedBox(height: AppSizes.spacingMedium),
          ...state.faktursToDisplay.map(
            (faktur) => _buildFakturItem(faktur, colorScheme, l10n),
          ),
        ],
      ],
    );
  }

  Widget _buildExpandedPaymentView(
    TransactionLoaded state,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        // Fixed Payment Header
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingLarge,
            vertical: AppSizes.paddingMedium,
          ),
          child: _buildSectionHeader(
            key: _paymentHeaderKey,
            title: l10n.transactionStatusPaid,
            onTap: _togglePaymentSection,
            colorScheme: colorScheme,
            showArrow: true,
            isExpanded: true,
          ),
        ),
        // Scrollable Payment List
        Expanded(
          child: ListView.builder(
            controller: _paymentScrollController,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLarge,
              vertical: AppSizes.paddingMedium,
            ),
            itemCount:
                state.displayPayments.length +
                (state.paymentLoading ? 1 : 0) +
                (state.allFakturs.isNotEmpty ? 1 : 0),
            itemBuilder: (context, index) {
              // Show loading at the bottom
              if (index == state.displayPayments.length &&
                  state.paymentLoading) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // Show faktur header at the bottom
              if (index ==
                  state.displayPayments.length +
                      (state.paymentLoading ? 1 : 0)) {
                return Column(
                  children: [
                    SizedBox(height: AppSizes.spacingXl),
                    _buildSectionHeader(
                      key: _fakturHeaderKey,
                      title: l10n.transactionTherapyDone,
                      onTap: _toggleFakturSection,
                      colorScheme: colorScheme,
                      showArrow: state.canExpandFaktur,
                    ),
                  ],
                );
              }

              // Show payment items
              return _buildPaymentItem(
                state.displayPayments[index],
                colorScheme,
                l10n,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedFakturView(
    TransactionLoaded state,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        // Payment Header (only if should show payments AND has payments)
        if (state.shouldShowPayments && state.allPayments.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLarge,
              vertical: AppSizes.paddingMedium,
            ),
            child: _buildSectionHeader(
              key: _paymentHeaderKey,
              title: l10n.transactionStatusPaid,
              onTap: _togglePaymentSection,
              colorScheme: colorScheme,
              showArrow: state.canExpandPayment,
            ),
          ),

        // Faktur Header - Fixed di atas (only if should show fakturs)
        if (state.shouldShowFakturs)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLarge,
              vertical: AppSizes.paddingMedium,
            ),
            child: _buildSectionHeader(
              key: _fakturHeaderKey,
              title: l10n.transactionTherapyDone,
              onTap: _toggleFakturSection,
              colorScheme: colorScheme,
              showArrow: true,
              isExpanded: true,
            ),
          ),

        // Scrollable Faktur List
        Expanded(
          child: ListView.builder(
            controller: _fakturScrollController,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLarge,
              vertical: AppSizes.paddingMedium,
            ),
            itemCount:
                state.displayFakturs.length + (state.fakturLoading ? 1 : 0),
            itemBuilder: (context, index) {
              // Show loading at the bottom
              if (index == state.displayFakturs.length && state.fakturLoading) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // Show faktur items
              return _buildFakturItem(
                state.displayFakturs[index],
                colorScheme,
                l10n,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    Key? key,
    required String title,
    VoidCallback? onTap,
    required ColorScheme colorScheme,
    bool showArrow = true,
    bool isExpanded = false,
  }) {
    return Material(
      key: key,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.paddingSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
              ),
              if (showArrow)
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded ? 0.25 : 0,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: colorScheme.onSurface.withAlpha(150),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentItem(
    PaymentData payment,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.spacingTiny),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: colorScheme.surfaceContainerHighest),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          onTap: () => _navigateToDetail(payment.id, "payment"),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingMedium),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColor.gold,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.solidCreditCard,
                    color: AppColor.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSizes.spacingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.paymentName ?? '',
                        style: AppTextStyle.supportText.withColor(
                          colorScheme.onSurface.withAlpha(150),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSizes.paddingTiny),
                      Text(
                        (payment.paymentFor?.isNotEmpty == true)
                            ? payment.paymentFor!
                            : l10n.transactionPaymentDefault,
                        style: AppTextStyle.body.withColor(
                          colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSizes.paddingTiny),
                      Text(
                        formatDate(payment.datePayment ?? '', context),
                        style: AppTextStyle.caption.withColor(
                          colorScheme.onSurface.withAlpha(120),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppSizes.spacingMedium),
                Text(
                  'Rp ${formatCurrency(payment.amountPayment ?? 0)}',
                  style: AppTextStyle.body.withColor(AppColor.green),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFakturItem(
    FakturData faktur,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    Widget iconWidget;
    Color iconColor;

    if (faktur.fakturFor != null &&
        faktur.fakturFor!.toLowerCase().contains('voucher')) {
      iconColor = AppColor.orange;
      iconWidget = Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.ticketSimple,
            color: AppColor.white,
            size: 20,
          ),
          Icon(FontAwesomeIcons.percent, size: 12, color: AppColor.orange),
        ],
      );
    } else {
      iconColor = AppColor.primary;
      iconWidget = const Icon(
        FontAwesomeIcons.heartPulse,
        color: AppColor.white,
        size: 20,
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.spacingTiny),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: colorScheme.surfaceContainerHighest),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          onTap: () => _navigateToDetail(faktur.id, "faktur"),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingMedium),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                  child: iconWidget,
                ),
                SizedBox(width: AppSizes.spacingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        faktur.fakturName ?? '',
                        style: AppTextStyle.supportText.withColor(
                          colorScheme.onSurface.withAlpha(150),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSizes.paddingTiny),
                      Text(
                        (faktur.fakturFor?.isNotEmpty == true)
                            ? faktur.fakturFor!
                            : l10n.transactionServiceDefault,
                        style: AppTextStyle.body.withColor(
                          colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSizes.paddingTiny),
                      Text(
                        formatDate(faktur.dateFaktur ?? '', context),
                        style: AppTextStyle.caption.withColor(
                          colorScheme.onSurface.withAlpha(120),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppSizes.spacingMedium),
                Text(
                  '-Rp ${formatCurrency(faktur.amountFaktur ?? 0)}',
                  style: AppTextStyle.body.withColor(colorScheme.error),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(
    TransactionError state,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            SizedBox(height: AppSizes.spacingMedium),
            Text(
              l10n.transactionErrorMessage(state.messageCode),
              textAlign: TextAlign.center,
              style: AppTextStyle.body.withColor(colorScheme.error),
            ),
            SizedBox(height: AppSizes.spacingLarge),
            ElevatedButton(
              onPressed: _loadInitialData,
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  String _getEmptyMessage(
    TransactionType transactionType,
    AppLocalizations l10n,
  ) {
    switch (transactionType) {
      case TransactionType.payment:
        return l10n.transactionNoPaymentFound;
      case TransactionType.service:
        return l10n.transactionNoServiceFound;
      case TransactionType.all:
        return l10n.noTransactionsFound;
    }
  }

  void _navigateToDetail(int transactionId, String type) {
    context.goNamed(
      AppRoutes.detailTransaction.name,
      pathParameters: {'id': transactionId.toString(), 'type': type},
    );
  }
}
