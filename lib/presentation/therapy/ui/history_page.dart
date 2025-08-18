import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/lab.dart';
import 'package:raho_member_apps/data/models/therapy.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/presentation/therapy/states/lab/lab_bloc.dart';
import 'package:raho_member_apps/presentation/therapy/states/therapy/therapy_bloc.dart';

part 'widget/dropdown_overlay.dart';

part 'widget/date_picker.dart';

part 'widget/dropdown_filter.dart';

part 'widget/filter_bottom_component.dart';

class HistoryPageWrapper extends StatelessWidget {
  const HistoryPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TherapyBloc>()),
        BlocProvider(create: (_) => sl<LabBloc>()),
      ],
      child: const HistoryPage(),
    );
  }
}

class FilterState {
  final String? company;
  final String? product;
  final String? dateFrom;
  final String? dateTo;

  const FilterState({this.company, this.product, this.dateFrom, this.dateTo});

  FilterState copyWith({
    String? company,
    String? product,
    String? dateFrom,
    String? dateTo,
  }) {
    return FilterState(
      company: company ?? this.company,
      product: product ?? this.product,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
    );
  }

  bool get hasActiveFilters =>
      company != null || product != null || dateFrom != null || dateTo != null;

  FilterState clear() => const FilterState();
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final AnimationController _tabAnimationController;

  bool _isTherapySelected = true;
  FilterState _therapyFilterState = const FilterState();
  FilterState _labFilterState = const FilterState();

  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupScrollListener();
    context.read<TherapyBloc>().add(const FetchTherapyList());
  }

  void _initializeControllers() {
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _tabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() {
    if (_isTherapySelected) {
      context.read<TherapyBloc>().add(const LoadMoreTherapy());
    } else {
      context.read<LabBloc>().add(const LoadMoreLab());
    }
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    _tabAnimationController.dispose();
    super.dispose();
  }

  void _switchTab(bool isTherapy) {
    if (_isTherapySelected == isTherapy) return;

    setState(() {
      _isTherapySelected = isTherapy;
    });

    _tabAnimationController.reset();
    _tabAnimationController.forward();

    if (isTherapy) {
      context.read<TherapyBloc>().add(const FetchTherapyList());
    } else {
      context.read<LabBloc>().add(const FetchLabList());
    }
  }

  void _onSearchChanged(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 300), () {
      if (_isTherapySelected) {
        context.read<TherapyBloc>().add(SearchTherapy(query));
      } else {
        context.read<LabBloc>().add(SearchLab(query));
      }
    });
  }

  void _showFilterBottomSheet() {
    final therapyBloc = context.read<TherapyBloc>();
    final labBloc = context.read<LabBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: therapyBloc),
          BlocProvider.value(value: labBloc),
        ],
        child: _FilterBottomSheet(
          isTherapySelected: _isTherapySelected,
          therapyFilterState: _therapyFilterState,
          labFilterState: _labFilterState,
          onApplyTherapyFilters: _applyTherapyFilters,
          onApplyLabFilters: _applyLabFilters,
          onClearFilters: _clearFilters,
        ),
      ),
    );
  }

  void _applyTherapyFilters(FilterState filterState) {
    setState(() {
      _therapyFilterState = filterState;
    });

    context.read<TherapyBloc>().add(
      FilterTherapy(
        companyName: filterState.company,
        productName: filterState.product,
        dateFrom: filterState.dateFrom,
        dateTo: filterState.dateTo,
      ),
    );
  }

  void _applyLabFilters(FilterState filterState) {
    setState(() {
      _labFilterState = filterState;
    });

    context.read<LabBloc>().add(
      FilterLab(
        companyName: filterState.company,
        dateFrom: filterState.dateFrom,
        dateTo: filterState.dateTo,
      ),
    );
  }

  void _clearFilters() {
    if (_isTherapySelected) {
      setState(() {
        _therapyFilterState = const FilterState();
      });
      context.read<TherapyBloc>().add(const ClearTherapyFilters());
    } else {
      setState(() {
        _labFilterState = const FilterState();
      });
      context.read<LabBloc>().add(const ClearLabFilters());
    }
  }

  FilterState get _currentFilterState =>
      _isTherapySelected ? _therapyFilterState : _labFilterState;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: SafeArea(
        child: Column(
          children: [
            // Header - Made const
            _HistoryHeader(title: l10n.historyPageTitle),

            // Tab Selector - Optimized
            _OptimizedTabSelector(
              isTherapySelected: _isTherapySelected,
              onTabChanged: _switchTab,
              animationController: _tabAnimationController,
            ),

            // Search Bar - Optimized
            _OptimizedSearchBar(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onFilterTap: _showFilterBottomSheet,
              hasActiveFilters: _currentFilterState.hasActiveFilters,
              isTherapySelected: _isTherapySelected,
            ),

            // History List - Optimized
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLarge,
                ),
                child: _isTherapySelected
                    ? _OptimizedTherapyContent(
                        scrollController: _scrollController,
                      )
                    : _OptimizedLabContent(scrollController: _scrollController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Optimized Header Widget
class _HistoryHeader extends StatelessWidget {
  const _HistoryHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.paddingLarge,
        AppSizes.spacingLarge,
        AppSizes.paddingLarge,
        AppSizes.spacingMedium,
      ),
      child: Text(
        title,
        style: AppTextStyle.title.withColor(
          Theme.of(context).colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Optimized Tab Selector
class _OptimizedTabSelector extends StatelessWidget {
  const _OptimizedTabSelector({
    required this.isTherapySelected,
    required this.onTabChanged,
    required this.animationController,
  });

  final bool isTherapySelected;
  final Function(bool) onTabChanged;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLarge,
        vertical: AppSizes.spacingMedium,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              text: l10n.therapyTabTherapy,
              isSelected: isTherapySelected,
              onTap: () => onTabChanged(true),
              animationController: animationController,
            ),
          ),
          Expanded(
            child: _TabButton(
              text: l10n.therapyTabLab,
              isSelected: !isTherapySelected,
              onTap: () => onTabChanged(false),
              animationController: animationController,
            ),
          ),
        ],
      ),
    );
  }
}

// Optimized Tab Button
class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.animationController,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.paddingMedium,
              horizontal: AppSizes.paddingLarge,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
            ),
            child: Center(
              child: Text(
                text,
                style: AppTextStyle.body
                    .withColor(
                      isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.primary,
                    )
                    .withWeight(AppFontWeight.medium),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Optimized Search Bar
class _OptimizedSearchBar extends StatelessWidget {
  const _OptimizedSearchBar({
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
    required this.hasActiveFilters,
    required this.isTherapySelected,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onFilterTap;
  final bool hasActiveFilters;
  final bool isTherapySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLarge,
        vertical: AppSizes.spacingMedium,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: onChanged,
          style: AppTextStyle.body.withColor(theme.colorScheme.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.colorScheme.surface,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              size: 20,
            ),
            suffixIcon: _FilterButton(
              onTap: onFilterTap,
              hasActiveFilters: hasActiveFilters,
            ),
            hintText: isTherapySelected
                ? l10n.therapySearchHint
                : l10n.labSearchHint,
            hintStyle: AppTextStyle.body.withColor(
              theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLarge,
              vertical: AppSizes.paddingMedium,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Optimized Filter Button
class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.onTap, required this.hasActiveFilters});

  final VoidCallback onTap;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.all(AppSizes.paddingTiny),
        decoration: BoxDecoration(
          color: hasActiveFilters
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
        ),
        child: Icon(
          Icons.tune_rounded,
          color: hasActiveFilters
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          size: 18,
        ),
      ),
    );
  }
}

// Optimized Therapy Content
class _OptimizedTherapyContent extends StatelessWidget {
  const _OptimizedTherapyContent({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<TherapyBloc, TherapyState>(
      listener: (context, state) {
        if (state is TherapyError && state.therapies == null) {
          _showErrorSnackBar(context, state.messageCode);
        }
      },
      builder: (context, state) => _buildTherapyList(context, l10n, state),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Widget _buildTherapyList(
    BuildContext context,
    AppLocalizations l10n,
    TherapyState state,
  ) {
    return switch (state) {
      TherapyLoading() => const Center(child: CircularProgressIndicator()),
      TherapyRefreshing(:final therapies) => _OptimizedTherapyListView(
        therapies: therapies,
        scrollController: scrollController,
        isRefreshing: true,
      ),
      TherapyListLoaded(:final therapies, :final isLoadingMore) =>
        _OptimizedTherapyListView(
          therapies: therapies,
          scrollController: scrollController,
          isLoadingMore: isLoadingMore,
        ),
      TherapyError(:final therapies) when therapies?.isNotEmpty == true =>
        _OptimizedTherapyListView(
          therapies: therapies!,
          scrollController: scrollController,
        ),
      TherapyError(:final messageCode) => _ErrorState(
        message: messageCode,
        onRetry: () =>
            context.read<TherapyBloc>().add(const FetchTherapyList()),
      ),
      _ => _EmptyState(
        icon: Icons.medical_services_rounded,
        title: l10n.therapyEmptyTitle,
        subtitle: l10n.therapyEmptySubtitle,
      ),
    };
  }
}

// Optimized Lab Content
class _OptimizedLabContent extends StatelessWidget {
  const _OptimizedLabContent({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<LabBloc, LabState>(
      listener: (context, state) {
        if (state is LabError && state.labs == null) {
          _showErrorSnackBar(context, state.messageCode);
        }
      },
      builder: (context, state) => _buildLabList(context, l10n, state),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Widget _buildLabList(
    BuildContext context,
    AppLocalizations l10n,
    LabState state,
  ) {
    return switch (state) {
      LabLoading() => const Center(child: CircularProgressIndicator()),
      LabRefreshing(:final labs) => _OptimizedLabListView(
        labs: labs,
        scrollController: scrollController,
        isRefreshing: true,
      ),
      LabListLoaded(:final labs, :final isLoadingMore) => _OptimizedLabListView(
        labs: labs,
        scrollController: scrollController,
        isLoadingMore: isLoadingMore,
      ),
      LabError(:final labs) when labs?.isNotEmpty == true =>
        _OptimizedLabListView(labs: labs!, scrollController: scrollController),
      LabError(:final messageCode) => _ErrorState(
        message: messageCode,
        onRetry: () => context.read<LabBloc>().add(const FetchLabList()),
      ),
      _ => _EmptyState(
        icon: Icons.science_rounded,
        title: l10n.labEmptyTitle,
        subtitle: l10n.labEmptySubtitle,
      ),
    };
  }
}

// Optimized Therapy List View
class _OptimizedTherapyListView extends StatelessWidget {
  const _OptimizedTherapyListView({
    required this.therapies,
    required this.scrollController,
    this.isRefreshing = false,
    this.isLoadingMore = false,
  });

  final List<TherapyData> therapies;
  final ScrollController scrollController;
  final bool isRefreshing;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (therapies.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return _EmptyState(
        icon: Icons.medical_services_rounded,
        title: l10n.therapyEmptyTitle,
        subtitle: l10n.therapyEmptySubtitle,
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<TherapyBloc>().add(const RefreshTherapyList());
      },
      child: ListView.separated(
        controller: scrollController,
        padding: EdgeInsets.only(bottom: AppSizes.spacingLarge),
        itemCount: therapies.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => SizedBox(height: AppSizes.spacingMedium),
        itemBuilder: (context, index) {
          if (index >= therapies.length) {
            return const _LoadingIndicator();
          }
          return _OptimizedTherapyCard(therapy: therapies[index]);
        },
      ),
    );
  }
}

// Optimized Lab List View
class _OptimizedLabListView extends StatelessWidget {
  const _OptimizedLabListView({
    required this.labs,
    required this.scrollController,
    this.isRefreshing = false,
    this.isLoadingMore = false,
  });

  final List<LabData> labs;
  final ScrollController scrollController;
  final bool isRefreshing;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (labs.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return _EmptyState(
        icon: Icons.science_rounded,
        title: l10n.labEmptyTitle,
        subtitle: l10n.labEmptySubtitle,
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<LabBloc>().add(const RefreshLabList());
      },
      child: ListView.separated(
        controller: scrollController,
        padding: EdgeInsets.only(bottom: AppSizes.spacingLarge),
        itemCount: labs.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => SizedBox(height: AppSizes.spacingMedium),
        itemBuilder: (context, index) {
          if (index >= labs.length) {
            return const _LoadingIndicator();
          }
          return _OptimizedLabCard(lab: labs[index]);
        },
      ),
    );
  }
}

// Optimized Cards
class _OptimizedTherapyCard extends StatelessWidget {
  const _OptimizedTherapyCard({required this.therapy});

  final TherapyData therapy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 2,
      shadowColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: InkWell(
        onTap: () => context.goNamed(
          AppRoutes.detailTherapy.name,
          pathParameters: {'id': therapy.id.toString()},
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          child: Row(
            children: [
              _TherapyIcon(),
              SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: _TherapyCardContent(therapy: therapy, l10n: l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TherapyIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Icon(
        Icons.medical_services_rounded,
        color: theme.colorScheme.onPrimary,
        size: 24,
      ),
    );
  }
}

class _TherapyCardContent extends StatelessWidget {
  const _TherapyCardContent({required this.therapy, required this.l10n});

  final TherapyData therapy;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${therapy.nameProduct} ${therapy.variant}",
          style: AppTextStyle.subtitle
              .withColor(theme.colorScheme.onSurface)
              .withWeight(AppFontWeight.semiBold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppSizes.spacingTiny),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    therapy.companyName ?? '',
                    style: AppTextStyle.caption.withColor(
                      theme.colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.paddingTiny),
                  Text(
                    therapy.date ?? '',
                    style: AppTextStyle.supportText.withColor(
                      theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSmall,
                    vertical: AppSizes.paddingTiny,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  ),
                  child: Text(
                    l10n.therapyCardInfusionNumber(therapy.infus.toString()),
                    style: AppTextStyle.supportText
                        .withColor(theme.colorScheme.secondary)
                        .withWeight(AppFontWeight.medium),
                  ),
                ),
                SizedBox(height: AppSizes.paddingTiny),
                Text(
                  therapy.nakes ?? '',
                  style: AppTextStyle.supportText.withColor(
                    theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// Similar optimizations for LabCard...
class _OptimizedLabCard extends StatelessWidget {
  const _OptimizedLabCard({required this.lab});

  final LabData lab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shadowColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to lab detail
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          child: Row(
            children: [
              _LabIcon(),
              SizedBox(width: AppSizes.spacingMedium),
              Expanded(child: _LabCardContent(lab: lab)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Icon(
        Icons.science_rounded,
        color: theme.colorScheme.onTertiary,
        size: 24,
      ),
    );
  }
}

class _LabCardContent extends StatelessWidget {
  const _LabCardContent({required this.lab});

  final LabData lab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.labTestTitle,
          style: AppTextStyle.subtitle
              .withColor(theme.colorScheme.onSurface)
              .withWeight(AppFontWeight.semiBold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppSizes.spacingTiny),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.companyName ?? '',
                    style: AppTextStyle.caption.withColor(
                      theme.colorScheme.tertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.paddingTiny),
                  Text(
                    lab.date ?? '',
                    style: AppTextStyle.supportText.withColor(
                      theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSmall,
                    vertical: AppSizes.paddingTiny,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  ),
                  child: Text(
                    l10n.labResultLabel,
                    style: AppTextStyle.supportText
                        .withColor(theme.colorScheme.tertiary)
                        .withWeight(AppFontWeight.medium),
                  ),
                ),
                SizedBox(height: AppSizes.paddingTiny),
                Text(
                  lab.labType ?? '',
                  style: AppTextStyle.supportText.withColor(
                    theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: AppSizes.spacingLarge),
          Text(
            title,
            style: AppTextStyle.subtitle.withColor(
              theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: AppSizes.spacingMedium),
          Text(
            subtitle,
            style: AppTextStyle.body.withColor(
              theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: theme.colorScheme.error.withValues(alpha: 0.7),
          ),
          SizedBox(height: AppSizes.spacingLarge),
          Text(
            l10n.errorStateTitle,
            style: AppTextStyle.subtitle.withColor(theme.colorScheme.error),
          ),
          SizedBox(height: AppSizes.spacingMedium),
          Text(
            message,
            style: AppTextStyle.body.withColor(
              theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSizes.spacingLarge),
          ElevatedButton(onPressed: onRetry, child: Text(l10n.errorStateRetry)),
        ],
      ),
    );
  }
}
