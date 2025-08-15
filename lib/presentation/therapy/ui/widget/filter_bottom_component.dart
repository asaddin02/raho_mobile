part of '../history_page.dart';

class _FilterBottomSheet extends StatefulWidget {
  const _FilterBottomSheet({
    required this.isTherapySelected,
    required this.therapyFilterState,
    required this.labFilterState,
    required this.onApplyTherapyFilters,
    required this.onApplyLabFilters,
    required this.onClearFilters,
  });

  final bool isTherapySelected;
  final FilterState therapyFilterState;
  final FilterState labFilterState;
  final Function(FilterState) onApplyTherapyFilters;
  final Function(FilterState) onApplyLabFilters;
  final VoidCallback onClearFilters;

  @override
  State<_FilterBottomSheet> createState() =>
      _FilterBottomSheetState();
}

class _FilterBottomSheetState
    extends State<_FilterBottomSheet> {
  late FilterState _currentFilterState;

  @override
  void initState() {
    super.initState();
    _currentFilterState = widget.isTherapySelected
        ? widget.therapyFilterState
        : widget.labFilterState;
  }

  void _updateFilter({
    String? company,
    String? product,
    String? dateFrom,
    String? dateTo,
    bool clearCompany = false,
    bool clearProduct = false,
    bool clearDateFrom = false,
    bool clearDateTo = false,
  }) {
    setState(() {
      _currentFilterState = _currentFilterState.copyWith(
        company: clearCompany ? null : (company ?? _currentFilterState.company),
        product: clearProduct ? null : (product ?? _currentFilterState.product),
        dateFrom: clearDateFrom
            ? null
            : (dateFrom ?? _currentFilterState.dateFrom),
        dateTo: clearDateTo ? null : (dateTo ?? _currentFilterState.dateTo),
      );
    });
  }

  void _clearAllFilters() {
    setState(() {
      _currentFilterState = const FilterState();
    });
    widget.onClearFilters();
  }

  void _applyFilters() {
    if (widget.isTherapySelected) {
      widget.onApplyTherapyFilters(_currentFilterState);
    } else {
      widget.onApplyLabFilters(_currentFilterState);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radiusLarge),
          topRight: Radius.circular(AppSizes.radiusLarge),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: AppSizes.spacingMedium),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.filterTitle,
                  style: AppTextStyle.subtitle.withColor(
                    theme.colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: Text(
                    l10n.filterClear,
                    style: AppTextStyle.body.withColor(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filters Content
          Padding(
            padding: EdgeInsets.all(AppSizes.paddingLarge),
            child: widget.isTherapySelected
                ? _buildTherapyFilters(l10n)
                : _buildLabFilters(l10n),
          ),
        ],
      ),
    );
  }

  Widget _buildTherapyFilters(AppLocalizations l10n) {
    return BlocBuilder<TherapyBloc, TherapyState>(
      builder: (context, state) {
        List<String> companies = [];
        List<String> products = [];

        if (state is TherapyListLoaded) {
          companies = state.filters.companies;
          products = state.filters.products;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilterSection(
              title: l10n.filterCompany,
              child: _FilterButtonIcon(
                icon: Icons.business_rounded,
                label: l10n.selectCompany,
                items: companies,
                selectedValue: _currentFilterState.company,
                onSelect: (value) => _updateFilter(company: value),
              ),
            ),
            SizedBox(height: AppSizes.spacingMedium),
            _FilterSection(
              title: l10n.filterProduct,
              child: _FilterButtonIcon(
                icon: Icons.inventory_rounded,
                label: l10n.selectProduct,
                items: products,
                selectedValue: _currentFilterState.product,
                onSelect: (value) => _updateFilter(product: value),
              ),
            ),
            SizedBox(height: AppSizes.spacingMedium),
            _FilterSection(
              title: l10n.filterDateRange,
              child: Row(
                children: [
                  Expanded(
                    child: _DatePickerButton(
                      label: l10n.dateFrom,
                      selectedDate: _currentFilterState.dateFrom,
                      onDateSelected: (date) => _updateFilter(dateFrom: date),
                    ),
                  ),
                  SizedBox(width: AppSizes.spacingMedium),
                  Expanded(
                    child: _DatePickerButton(
                      label: l10n.dateTo,
                      selectedDate: _currentFilterState.dateTo,
                      onDateSelected: (date) => _updateFilter(dateTo: date),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spacingLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: Text(l10n.applyFilter),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLabFilters(AppLocalizations l10n) {
    return BlocBuilder<LabBloc, LabState>(
      builder: (context, state) {
        List<String> companies = [];

        if (state is LabListLoaded) {
          companies = state.filters.companies;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilterSection(
              title: l10n.filterCompany,
              child: _FilterButtonIcon(
                icon: Icons.business_rounded,
                label: l10n.selectCompany,
                items: companies,
                selectedValue: _currentFilterState.company,
                onSelect: (value) => _updateFilter(company: value),
              ),
            ),
            SizedBox(height: AppSizes.spacingMedium),
            _FilterSection(
              title: l10n.filterDateRange,
              child: Row(
                children: [
                  Expanded(
                    child: _DatePickerButton(
                      label: l10n.dateFrom,
                      selectedDate: _currentFilterState.dateFrom,
                      onDateSelected: (date) => _updateFilter(dateFrom: date),
                    ),
                  ),
                  SizedBox(width: AppSizes.spacingMedium),
                  Expanded(
                    child: _DatePickerButton(
                      label: l10n.dateTo,
                      selectedDate: _currentFilterState.dateTo,
                      onDateSelected: (date) => _updateFilter(dateTo: date),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spacingLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: Text(l10n.applyFilter),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.body.withColor(
            Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: AppSizes.spacingSmall),
        child,
      ],
    );
  }
}

// Optimized Filter Button with better performance
class _FilterButtonIcon extends StatelessWidget {
  const _FilterButtonIcon({
    required this.icon,
    required this.label,
    required this.items,
    required this.onSelect,
    this.selectedValue,
  });

  final IconData icon;
  final String label;
  final List<String> items;
  final Function(String) onSelect;
  final String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _DropdownFilter(
      items: items,
      selectedValue: selectedValue,
      onSelect: onSelect,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.paddingMedium,
          horizontal: AppSizes.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.3),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              size: 16,
            ),
            SizedBox(width: AppSizes.spacingTiny),
            Expanded(
              child: Text(
                selectedValue ?? label,
                style: AppTextStyle.caption.withColor(
                  selectedValue != null
                      ? colorScheme.onSurface
                      : colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: AppSizes.spacingTiny),
            Icon(
              Icons.keyboard_arrow_down,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}