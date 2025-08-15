import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';

class PrimaryButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final EdgeInsets? padding;

  final Widget? child;
  final IconData? icon;
  final IconData? suffixIcon;
  final double iconSize;
  final double iconSpacing;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Gradient? gradient;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final bool useGradient;
  final bool hasElevation;

  const PrimaryButton({
    super.key,
    this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.padding,
    this.child,
    this.icon,
    this.suffixIcon,
    this.iconSize = 20,
    this.iconSpacing = 8,
    this.backgroundColor,
    this.disabledColor,
    this.gradient,
    this.textColor,
    this.textStyle,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius,
    this.boxShadow,
    this.useGradient = true,
    this.hasElevation = true,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !widget.isDisabled && !widget.isLoading;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: Container(
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          gradient: isEnabled && widget.useGradient
              ? widget.gradient ??
                    LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColor.primary, AppColor.primaryDark],
                    )
              : null,
          color: isEnabled
              ? (widget.useGradient
                    ? null
                    : widget.backgroundColor ?? AppColor.primary)
              : widget.disabledColor ?? AppColor.grey,
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(AppSizes.radiusXxl),
          border: widget.borderWidth > 0
              ? Border.all(
                  color: widget.borderColor ?? Colors.transparent,
                  width: widget.borderWidth,
                )
              : null,
          boxShadow: isEnabled && widget.hasElevation
              ? widget.boxShadow ??
                    [
                      BoxShadow(
                        color: (widget.backgroundColor ?? AppColor.primary)
                            .withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: (widget.backgroundColor ?? AppColor.primary)
                            .withValues(alpha: 0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 10),
                      ),
                    ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled ? widget.onPressed : null,
            onTapDown: isEnabled
                ? (_) => _animationController.forward(from: 0)
                : null,
            onTapUp: isEnabled ? (_) => _animationController.reverse() : null,
            onTapCancel: isEnabled
                ? () => _animationController.reverse()
                : null,
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(AppSizes.radiusXxl),
            child: Container(
              padding:
                  widget.padding ??
                  EdgeInsets.symmetric(
                    vertical: AppSizes.paddingLarge,
                    horizontal: AppSizes.paddingXl,
                  ),
              alignment: Alignment.center,
              child: widget.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.textColor ?? AppColor.white,
                        ),
                      ),
                    )
                  : widget.child ?? _buildButtonContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    final hasIcon = widget.icon != null;
    final hasSuffixIcon = widget.suffixIcon != null;
    final textWidget = Text(
      widget.text!,
      style:
          widget.textStyle ??
          AppTextStyle.subtitle
              .withWeight(AppFontWeight.bold)
              .withColor(widget.textColor ?? AppColor.white),
    );

    if (!hasIcon && !hasSuffixIcon) {
      return textWidget;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasIcon) ...[
          Icon(
            widget.icon,
            color: widget.textColor ?? AppColor.white,
            size: widget.iconSize,
          ),
          SizedBox(width: widget.iconSpacing),
        ],
        textWidget,
        if (hasSuffixIcon) ...[
          SizedBox(width: widget.iconSpacing),
          Icon(
            widget.suffixIcon,
            color: widget.textColor ?? AppColor.white,
            size: widget.iconSize,
          ),
        ],
      ],
    );
  }
}
