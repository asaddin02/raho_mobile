import 'package:flutter/material.dart';
import 'dart:math' as math;

class DottedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Color color;
  final double gap;
  final double radius;

  const DottedBorder({
    super.key,
    required this.child,
    this.strokeWidth = 1,
    this.color = Colors.black,
    this.gap = 5,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        strokeWidth: strokeWidth,
        color: color,
        gap: gap,
        radius: radius,
      ),
      child: Container(
        child: child,
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;
  final double radius;

  _DottedBorderPainter({
    required this.strokeWidth,
    required this.color,
    required this.gap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();

    // Top line
    for (double i = 0; i < size.width; i += gap * 2) {
      path.moveTo(i, 0);
      path.lineTo(math.min(i + gap, size.width), 0);
    }

    // Right line
    for (double i = 0; i < size.height; i += gap * 2) {
      path.moveTo(size.width, i);
      path.lineTo(size.width, math.min(i + gap, size.height));
    }

    // Bottom line
    for (double i = size.width; i > 0; i -= gap * 2) {
      path.moveTo(i, size.height);
      path.lineTo(math.max(i - gap, 0), size.height);
    }

    // Left line
    for (double i = size.height; i > 0; i -= gap * 2) {
      path.moveTo(0, i);
      path.lineTo(0, math.max(i - gap, 0));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
