import 'package:flutter/material.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'dart:math' as math;
import 'package:raho_mobile/core/styles/app_text_style.dart';

class CustomDropdown extends StatefulWidget {
  final Widget child;
  final List<String> items;
  final Function(String) onSelect;
  final double maxHeight; // Add maximum height property

  const CustomDropdown({
    super.key,
    required this.child,
    required this.items,
    required this.onSelect,
    this.maxHeight = 200, // Default max height
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;
    final position = renderBox.localToGlobal(Offset.zero);

    // Calculate available space below and above
    final spaceBelow = screenSize.height - position.dy - size.height;
    final spaceAbove = position.dy;

    // Determine if dropdown should go above or below
    final showBelow =
        spaceBelow >= widget.maxHeight || spaceBelow >= spaceAbove;
    final actualHeight = showBelow
        ? math.min(spaceBelow - 10, widget.maxHeight)
        : math.min(spaceAbove - 10, widget.maxHeight);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () => _removeOverlay(),
            child: Container(
              color: Colors.transparent,
              width: screenSize.width,
              height: screenSize.height,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset:
                  Offset(0, showBelow ? size.height + 5 : -actualHeight - 5),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                color: AppColor.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: actualHeight,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.items.map((item) {
                          return InkWell(
                            onTap: () {
                              widget.onSelect(item);
                              _removeOverlay();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              width: double.infinity,
                              child: Text(
                                item,
                                style: AppFontStyle.s12.regular.black,
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
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isOpen = true;
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
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: widget.child,
      ),
    );
  }
}
