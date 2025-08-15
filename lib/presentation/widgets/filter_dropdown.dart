import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';

class FilterDropdown extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> items;
  final Function(String) onSelect;

  const FilterDropdown({super.key,
    required this.icon,
    required this.label,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomDropdown(
      items: items,
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
            color: colorScheme.surfaceContainerHighest,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withAlpha(25),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: colorScheme.onSurface, size: 16),
            SizedBox(width: AppSizes.spacingTiny),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.caption.withColor(colorScheme.onSurface),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: AppSizes.spacingTiny),
            Icon(
              Icons.keyboard_arrow_down,
              color: colorScheme.onSurface,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}


class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String) onSelect;
  final Widget child;
  final double maxHeight;
  final String? selectedValue;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onSelect,
    required this.child,
    this.maxHeight = 300,
    this.selectedValue,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _animationController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _isOpen = false;
      });
    }
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;
    final position = renderBox.localToGlobal(Offset.zero);
    final colorScheme = Theme.of(context).colorScheme;

    final spaceBelow = screenSize.height - position.dy - size.height;
    final spaceAbove = position.dy;

    final showBelow =
        spaceBelow >= widget.maxHeight || spaceBelow >= spaceAbove;
    final actualHeight = showBelow
        ? math.min(spaceBelow - 10, widget.maxHeight)
        : math.min(spaceAbove - 10, widget.maxHeight);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Backdrop
          GestureDetector(
            onTap: () => _removeOverlay(),
            child: Container(
              color: Colors.black.withValues(alpha: 0.1),
              width: screenSize.width,
              height: screenSize.height,
            ),
          ),
          // Dropdown content
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                showBelow ? size.height + 8 : -actualHeight - 8,
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: showBelow
                        ? Alignment.topCenter
                        : Alignment.bottomCenter,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusSmall,
                        ),
                        color: colorScheme.surface,
                        shadowColor: colorScheme.shadow,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusSmall,
                            ),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: actualHeight,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusSmall,
                              ),
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(
                                  context,
                                ).copyWith(scrollbars: false),
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: AppSizes.paddingTiny,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: widget.items.asMap().entries.map((
                                        entry,
                                      ) {
                                        final item = entry.value;
                                        final isSelected =
                                            widget.selectedValue == item;

                                        return Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              widget.onSelect(item);
                                              _removeOverlay();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: AppSizes.paddingSmall,
                                                horizontal:
                                                    AppSizes.paddingMedium,
                                              ),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? colorScheme.primary
                                                          .withValues(
                                                            alpha: 0.1,
                                                          )
                                                    : Colors.transparent,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      item,
                                                      style: AppTextStyle
                                                          .caption
                                                          .withColor(
                                                            isSelected
                                                                ? colorScheme
                                                                      .primary
                                                                : colorScheme
                                                                      .onSurface,
                                                          )
                                                          .withWeight(
                                                            isSelected
                                                                ? AppFontWeight
                                                                      .medium
                                                                : AppFontWeight
                                                                      .regular,
                                                          ),
                                                    ),
                                                  ),
                                                  if (isSelected)
                                                    Icon(
                                                      Icons.check,
                                                      size: 16,
                                                      color:
                                                          colorScheme.primary,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isOpen = true;
    _animationController.forward();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(onTap: _toggleDropdown, child: widget.child),
    );
  }
}

// Update FilterButton untuk mendukung selected value
class _FilterButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<String> items;
  final Function(String) onSelect;

  const _FilterButton({
    required this.icon,
    required this.label,
    required this.items,
    required this.onSelect,
  });

  @override
  State<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomDropdown(
      items: widget.items,
      selectedValue: selectedValue,
      onSelect: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onSelect(value);
      },
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
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              size: 16,
            ),
            SizedBox(width: AppSizes.spacingTiny),
            Expanded(
              child: Text(
                selectedValue ?? widget.label,
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
