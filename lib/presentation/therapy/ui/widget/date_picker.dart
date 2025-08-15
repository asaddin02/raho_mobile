part of '../history_page.dart';

class _DatePickerButton extends StatelessWidget {
  const _DatePickerButton({
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final String label;
  final String? selectedDate;
  final Function(String) onDateSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _showDatePicker(context),
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
          children: [
            Icon(
              Icons.calendar_today,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              size: 16,
            ),
            SizedBox(width: AppSizes.spacingTiny),
            Expanded(
              child: Text(
                selectedDate ?? label,
                style: AppTextStyle.caption.withColor(
                  selectedDate != null
                      ? colorScheme.onSurface
                      : colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate != null
          ? DateTime.tryParse(selectedDate!) ?? DateTime.now()
          : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      onDateSelected(picked.toIso8601String().split('T')[0]);
    }
  }
}
