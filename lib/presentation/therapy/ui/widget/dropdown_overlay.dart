part of '../history_page.dart';

class _DropdownOverlay extends StatelessWidget {
  const _DropdownOverlay({
    required this.layerLink,
    required this.size,
    required this.position,
    required this.items,
    required this.onSelect,
    required this.onTapOutside,
    required this.scaleAnimation,
    required this.opacityAnimation,
    this.selectedValue,
  });

  final LayerLink layerLink;
  final Size size;
  final Offset position;
  final List<String> items;
  final String? selectedValue;
  final Function(String) onSelect;
  final VoidCallback onTapOutside;
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;

    const maxHeight = 200.0;
    final spaceBelow = screenSize.height - position.dy - size.height;
    final showBelow = spaceBelow >= maxHeight || spaceBelow >= position.dy;
    final actualHeight = math.min(
      maxHeight,
      showBelow ? spaceBelow - 10 : position.dy - 10,
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: onTapOutside,
          child: Container(
            color: Colors.transparent,
            width: screenSize.width,
            height: screenSize.height,
          ),
        ),
        Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, showBelow ? size.height + 4 : -actualHeight - 4),
            child: AnimatedBuilder(
              animation: scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnimation.value,
                  alignment: showBelow
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                      color: colorScheme.surface,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: actualHeight),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.paddingTiny,
                          ),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            final isSelected = selectedValue == item;

                            return InkWell(
                              onTap: () => onSelect(item),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.paddingSmall,
                                  horizontal: AppSizes.paddingMedium,
                                ),
                                color: isSelected
                                    ? colorScheme.primary.withValues(alpha: 0.1)
                                    : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: AppTextStyle.caption.withColor(
                                          isSelected
                                              ? colorScheme.primary
                                              : colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check,
                                        size: 16,
                                        color: colorScheme.primary,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
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
    );
  }
}
