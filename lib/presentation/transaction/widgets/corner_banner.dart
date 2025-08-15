import 'package:flutter/material.dart';
import 'dart:math' as math;

const double _contentRatio = 3 / 4;
const double _maxBannerSize = 100;
const double _minBannerSize = 40;
const double _rotateAngle = math.pi / 4;

class CornerBanner extends StatelessWidget {
  final bool showBanner;
  final BannerPosition bannerPosition;
  final String? bannerText;
  final TextStyle? bannerTextStyle;
  final Widget? bannerIcon;
  final bool bannerIconRotation;
  final Color? bannerColor;
  final double bannerSize;
  final EdgeInsets? contentPadding;
  final Widget? child;

  const CornerBanner({
    super.key,
    this.showBanner = true,
    this.bannerPosition = BannerPosition.topRight,
    this.bannerText,
    this.bannerTextStyle,
    this.bannerSize = 40.0,
    this.bannerIcon,
    this.bannerIconRotation = false,
    this.bannerColor,
    this.child,
    this.contentPadding,
  }) : assert(bannerText != null || bannerIcon != null);

  Alignment _contentAlignment() {
    switch (bannerPosition) {
      case BannerPosition.topLeft:
        return Alignment.topLeft;
      case BannerPosition.topRight:
        return Alignment.topRight;
      case BannerPosition.bottomLeft:
        return Alignment.bottomLeft;
      case BannerPosition.bottomRight:
        return Alignment.bottomRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bannerSizeActually = bannerSize.clamp(
      _minBannerSize,
      _maxBannerSize,
    );

    final double contentSizeActually = bannerSizeActually * _contentRatio;

    final double halfBannerSize = bannerSize / 2;
    final double squareRoot = math.sqrt(
      (halfBannerSize * halfBannerSize) + (halfBannerSize * halfBannerSize),
    );
    final double iconSizeActually = squareRoot / 2;

    return Stack(
      children: [
        // Child content remains unchanged - no padding applied
        child ?? const SizedBox.shrink(),
        if (showBanner)
          Positioned(
            top:
                bannerPosition == BannerPosition.topLeft ||
                    bannerPosition == BannerPosition.topRight
                ? 0
                : null,
            bottom:
                bannerPosition == BannerPosition.bottomLeft ||
                    bannerPosition == BannerPosition.bottomRight
                ? 0
                : null,
            left:
                bannerPosition == BannerPosition.topLeft ||
                    bannerPosition == BannerPosition.bottomLeft
                ? 0
                : null,
            right:
                bannerPosition == BannerPosition.topRight ||
                    bannerPosition == BannerPosition.bottomRight
                ? 0
                : null,
            child: ClipPath(
              clipper: BannerClipper(bannerPosition, _contentRatio),
              child: Container(
                decoration: BoxDecoration(
                  color: bannerColor ?? Colors.blueAccent,
                ),
                height: bannerSizeActually,
                width: bannerSizeActually,
                child: Align(
                  alignment: _contentAlignment(),
                  child: Transform.rotate(
                    angle: (bannerIcon != null && !bannerIconRotation)
                        ? 0
                        : bannerPosition == BannerPosition.topLeft ||
                              bannerPosition == BannerPosition.bottomRight
                        ? -_rotateAngle
                        : _rotateAngle,
                    child: Container(
                      padding: contentPadding ?? const EdgeInsets.all(2),
                      height: contentSizeActually,
                      width: contentSizeActually,
                      child: bannerIcon != null
                          ? Align(
                              child: SizedBox(
                                height: iconSizeActually,
                                width: iconSizeActually,
                                child: FittedBox(child: bannerIcon),
                              ),
                            )
                          : FittedBox(
                              child: Text(
                                bannerText!,
                                style:
                                    bannerTextStyle ??
                                    const TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  final BannerPosition position;
  final double contentRatio;

  BannerClipper(this.position, this.contentRatio);

  @override
  Path getClip(Size size) {
    var path = Path();

    switch (position) {
      case BannerPosition.topRight:
        path.moveTo(0, 0);
        path.lineTo(contentRatio / math.sqrt2 * size.width, 0);
        path.lineTo(
          size.width,
          (1 - (contentRatio / math.sqrt2)) * size.height,
        );
        path.lineTo(size.width, size.height);
        break;
      case BannerPosition.topLeft:
        path.moveTo(size.width, 0);
        path.lineTo((1 - (contentRatio / math.sqrt2)) * size.width, 0);
        path.lineTo(0, (1 - (contentRatio / math.sqrt2)) * size.height);
        path.lineTo(0, size.height);
        break;
      case BannerPosition.bottomLeft:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(
          size.width * (1 - (contentRatio / math.sqrt2)),
          size.height,
        );
        path.lineTo(0, size.height * (contentRatio / math.sqrt2));
        break;
      case BannerPosition.bottomRight:
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height * (contentRatio / math.sqrt2));
        path.lineTo(size.width * (contentRatio / math.sqrt2), size.height);
        path.lineTo(0, size.height);
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

enum BannerPosition { topLeft, topRight, bottomLeft, bottomRight }
