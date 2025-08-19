import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_assets.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/detail_transaction.dart';
import 'package:raho_member_apps/data/repositories/transaction_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/presentation/transaction/states/transaction/transaction_bloc.dart';
import 'package:raho_member_apps/presentation/transaction/widgets/corner_banner.dart';

class DetailTransactionWrapper extends StatelessWidget {
  final int transactionId;
  final String transactionType;

  const DetailTransactionWrapper({
    super.key,
    required this.transactionId,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TransactionBloc(repository: sl<TransactionRepository>())..add(
            FetchDetailTransactionEvent(
              transactionId: transactionId,
              transactionType: transactionType,
            ),
          ),
      child: DetailTransaction(
        transactionId: transactionId,
        transactionType: transactionType,
      ),
    );
  }
}

class DetailTransaction extends StatelessWidget {
  final int transactionId;
  final String transactionType;

  const DetailTransaction({
    super.key,
    required this.transactionId,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppSizes.spacingMedium,
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
                    l10n.transactionDetailTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subtitle.withColor(
                      colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
          ),
        ),
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is DetailTransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailTransactionError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.paddingLarge),
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
                        state.getLocalizedMessage(context),
                        style: AppTextStyle.body.withColor(colorScheme.error),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSizes.spacingLarge),
                      ElevatedButton(
                        onPressed: () {
                          context.read<TransactionBloc>().add(
                            FetchDetailTransactionEvent(
                              transactionId: transactionId,
                              transactionType: transactionType,
                            ),
                          );
                        },
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is DetailTransactionLoaded && state.data != null) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddingLarge,
                ),
                child: _buildTransactionCard(
                  context,
                  colorScheme,
                  l10n,
                  state.data!,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTransactionCard(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
    TransactionDetailData detail,
  ) {
    final isFaktur = transactionType == 'faktur';
    final isPayment = transactionType == 'payment';

    return Card(
      elevation: 2,
      shadowColor: AppColor.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(colorScheme, l10n),
          if (isFaktur) _buildPaymentStatus(colorScheme, l10n, detail),
          _buildTransactionDetails(
            colorScheme,
            l10n,
            detail,
            isFaktur,
            isPayment,
          ),
          SizedBox(height: AppSizes.spacingLarge),
          _buildActionButtons(context, colorScheme, l10n),
          if (detail.isVoucherPayment) ...[
            SizedBox(height: AppSizes.spacingSmall),
            _buildVoucherButton(context, colorScheme, l10n),
          ],
          SizedBox(height: AppSizes.spacingSmall),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.surfaceContainerHighest,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.logoApp, width: 50, height: 50),
          SizedBox(width: AppSizes.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.companyClubName,
                  style: AppTextStyle.body
                      .withColor(colorScheme.primary)
                      .withWeight(AppFontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(
                  l10n.companyTagline,
                  style: AppTextStyle.caption
                      .withColor(colorScheme.onSurface)
                      .withWeight(AppFontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStatus(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    TransactionDetailData detail,
  ) {
    String bannerText = l10n.transactionStatusPending;
    Color bannerColor = AppColor.orange;

    if (detail.paymentState == 'paid') {
      bannerText = l10n.transactionStatusPaid;
      bannerColor = AppColor.green;
    } else if (detail.paymentState == 'cancelled') {
      bannerText = l10n.transactionStatusCancelled;
      bannerColor = AppColor.primary;
    }

    return CornerBanner(
      showBanner: true,
      bannerPosition: BannerPosition.topRight,
      bannerText: bannerText,
      bannerTextStyle: AppTextStyle.supportText.withColor(AppColor.white),
      bannerColor: bannerColor,
      bannerSize: 70,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          AppSizes.paddingLarge,
          AppSizes.paddingLarge,
          AppSizes.paddingLarge,
          AppSizes.paddingMedium,
        ),
        width: double.infinity,
        child: Column(
          children: [
            if (detail.paymentState == 'paid')
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddingTiny,
                ),
                decoration: BoxDecoration(
                  color: AppColor.greenSoft,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXxl),
                ),
                child: Text(
                  l10n.transactionTherapyDone,
                  style: AppTextStyle.supportText.withColor(AppColor.black),
                ),
              ),
            SizedBox(height: AppSizes.spacingSmall),
            Text(
              _formatDate(detail.dateTransaction),
              style: AppTextStyle.supportText.withColor(
                colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingMedium),
            Text(
              detail.formattedTotalAmount,
              style: AppTextStyle.title.withColor(colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionDetails(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    TransactionDetailData detail,
    bool isFaktur,
    bool isPayment,
  ) {
    final List<(String, String)> details = [];

    // Common fields
    details.add((l10n.transactionDetailMemberName, detail.memberName));
    details.add((l10n.transactionDetailInvoiceNumber, detail.invoice));
    details.add((
      l10n.transactionDetailDate,
      _formatDate(detail.dateTransaction),
    ));

    // Payment specific fields
    if (isPayment) {
      if (detail.companyName != null && detail.companyName!.isNotEmpty) {
        details.add((l10n.transactionDetailBranchClinic, detail.companyName!));
      }

      // Voucher specific fields
      if (detail.isVoucherPayment) {
        if (detail.qtyVoucherNormal != null) {
          details.add((
            l10n.transactionDetailVoucherQty,
            detail.qtyVoucherNormal!.toStringAsFixed(0),
          ));
        }
        if (detail.qtyVoucherFree != null && detail.qtyVoucherFree! > 0) {
          details.add((
            l10n.transactionDetailFreeVoucher,
            detail.qtyVoucherFree!.toStringAsFixed(0),
          ));
        }
        if (detail.amountPerPcs != null) {
          details.add((
            l10n.transactionDetailUnitPrice,
            'Rp ${formatCurrency(detail.amountPerPcs!)}',
          ));
        }
      }
    }

    // Faktur specific fields
    if (isFaktur) {
      if (detail.admin != null && detail.admin!.isNotEmpty) {
        details.add((l10n.transactionDetailAdmin, detail.admin!));
      }
      if (detail.paymentState != null) {
        details.add((
          l10n.transactionDetailPaymentStatus,
          _getPaymentStateLabel(detail.paymentState!, l10n),
        ));
      }
    }

    // Total amount (common)
    details.add((
      l10n.transactionDetailTotalAmount,
      detail.formattedTotalAmount,
    ));

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSizes.paddingMedium,
        AppSizes.spacingSmall,
        AppSizes.paddingMedium,
        0,
      ),
      child: Column(
        children: details
            .map((detail) => _buildDetailRow(detail.$1, detail.$2, colorScheme))
            .toList(),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ColorScheme colorScheme) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.spacingSmall),
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingTiny),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: AppTextStyle.caption.withColor(
                colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          SizedBox(width: AppSizes.spacingTiny),
          Text(
            ":",
            style: AppTextStyle.supportText.withColor(
              colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(width: AppSizes.spacingTiny),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: AppTextStyle.caption
                  .withColor(colorScheme.onSurface)
                  .withWeight(AppFontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO: Implement download functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("l10n.featureComingSoon")),
                    );
                  },
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusSmall),
                    bottomLeft: Radius.circular(AppSizes.radiusSmall),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.paddingMedium,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          color: colorScheme.onSurface,
                          size: 16,
                        ),
                        SizedBox(width: AppSizes.paddingTiny),
                        Text(
                          l10n.transactionActionDownload,
                          style: AppTextStyle.supportText.withColor(
                            colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(width: 0.5, color: colorScheme.surfaceContainerHighest),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO: Implement share functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("l10n.featureComingSoon")),
                    );
                  },
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppSizes.radiusSmall),
                    bottomRight: Radius.circular(AppSizes.radiusSmall),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.paddingMedium,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: colorScheme.onSurface,
                          size: 16,
                        ),
                        SizedBox(width: AppSizes.paddingTiny),
                        Text(
                          l10n.transactionActionShare,
                          style: AppTextStyle.supportText.withColor(
                            colorScheme.onSurface,
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
      ),
    );
  }

  Widget _buildVoucherButton(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            // TODO: Navigate to voucher redemption
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("l10n.featureComingSoon")));
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
            side: BorderSide(color: colorScheme.primary, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_activity, color: colorScheme.primary, size: 16),
              SizedBox(width: AppSizes.paddingTiny),
              Text(
                l10n.transactionActionSeeRedeemVoucher,
                style: AppTextStyle.caption.withColor(colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPaymentStateLabel(String state, AppLocalizations l10n) {
    switch (state) {
      case 'paid':
        return l10n.transactionStatusPaid;
      case 'cancelled':
        return l10n.transactionStatusCancelled;
      case 'pending':
      default:
        return l10n.transactionStatusPending;
    }
  }

  String _formatDate(String date) {
    if (date.isEmpty) return '-';
    try {
      final dateObj = DateTime.parse(date);
      return '${dateObj.day}/${dateObj.month}/${dateObj.year}';
    } catch (e) {
      return date;
    }
  }

  String formatCurrency(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
