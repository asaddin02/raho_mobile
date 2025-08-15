import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/company.dart';
import 'package:raho_member_apps/presentation/profile/states/company/company_bloc.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class BranchLocationPage extends StatelessWidget {
  const BranchLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CompanyBloc>()..add(const GetCompanyBranchesEvent()),
      child: BackdropApps(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSizes.spacingXl + AppSizes.spacingMedium,
            left: AppSizes.paddingMedium,
            right: AppSizes.paddingMedium,
          ),
          child: Column(
            children: [
              // Header Section
              _buildHeader(context),

              // Content Section
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
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
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(51),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
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
              l10n.branchLocationTitle,
              style: AppTextStyle.title.withColor(
                Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state is CompanyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: l10n.branchLocationRetry,
                onPressed: () {
                  context.read<CompanyBloc>().reload();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          margin: EdgeInsets.only(
            bottom: AppSizes.paddingMedium,
            left: AppSizes.paddingTiny,
            right: AppSizes.paddingTiny,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(25),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: state is CompanyLoaded
              ? _buildBranchList(context, state.companies)
              : state is CompanyError
              ? _buildErrorWidget(context)
              : _buildLoadingWidget(context),
        );
      },
    );
  }

  Widget _buildBranchList(BuildContext context, List<Company> companies) {
    if (companies.isEmpty) {
      return _buildEmptyWidget(context);
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: companies.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSizes.spacingMedium),
      itemBuilder: (context, index) {
        final company = companies[index];
        return _buildBranchItem(context, company);
      },
    );
  }

  Widget _buildBranchItem(BuildContext context, Company company) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            height: AppSizes.spacingXl + AppSizes.paddingTiny,
            width: AppSizes.spacingXl + AppSizes.paddingTiny,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
            child: Icon(
              Icons.location_on,
              size: AppSizes.paddingLarge + 4,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),

          SizedBox(width: AppSizes.paddingMedium),

          // Branch Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Branch Name
                Text(
                  company.name,
                  style: AppTextStyle.subtitle
                      .withWeight(AppFontWeight.semiBold)
                      .withColor(
                        Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),

                SizedBox(height: AppSizes.paddingSmall),

                // Detail
                if (company.detail.isNotEmpty) ...[
                  Text(
                    company.detail,
                    style: AppTextStyle.body.withColor(
                      Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer.withAlpha(180),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.paddingSmall),
                ],

                // Phone Number
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: AppSizes.paddingMedium + 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: AppSizes.paddingTiny),
                    Text(
                      company.mobile,
                      style: AppTextStyle.caption.withColor(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Button
          GestureDetector(
            onTap: () {
              _handleBranchAction(company);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(AppSizes.paddingSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(30),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
              child: Icon(
                Icons.directions_outlined,
                size: AppSizes.paddingLarge,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: GestureDetector(
        onTap: () {
          context.read<CompanyBloc>().reload();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error.withAlpha(20),
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            border: Border.all(
              color: Theme.of(context).colorScheme.error.withAlpha(100),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.error,
                size: AppSizes.spacingLarge,
              ),
              SizedBox(height: AppSizes.paddingSmall),
              Text(
                l10n.branchLocationReload,
                style: AppTextStyle.subtitle.withColor(
                  Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: AppSizes.paddingMedium),
          Text(
            l10n.branchLocationLoading,
            style: AppTextStyle.body.withColor(
              Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_off_outlined,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
              size: AppSizes.spacingXl + AppSizes.paddingLarge,
            ),
            SizedBox(height: AppSizes.paddingMedium),
            Text(
              l10n.branchLocationEmpty,
              style: AppTextStyle.subtitle.withColor(
                Theme.of(context).colorScheme.onSurface.withAlpha(150),
              ),
            ),
            SizedBox(height: AppSizes.paddingSmall),
            Text(
              l10n.branchLocationEmptyHint,
              style: AppTextStyle.caption.withColor(
                Theme.of(context).colorScheme.onSurface.withAlpha(120),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBranchAction(Company company) {
    print("Branch action for: ${company.name}");
  }
}
