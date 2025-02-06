import 'package:flutter/material.dart';
import 'dart:math' as math;

class HalfCircle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final bool isLeftSide;

  const HalfCircle({
    super.key,
    this.width = 100,
    this.height = 200,
    this.color = Colors.blue,
    this.isLeftSide = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: HalfCirclePainter(
        color: color,
        isLeftSide: isLeftSide,
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  final Color color;
  final bool isLeftSide;

  HalfCirclePainter({
    required this.color,
    required this.isLeftSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    if (isLeftSide) {
      path.moveTo(size.width, 0);
      path.arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(size.width),
        clockwise: false,
      );
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, 0);
      path.arcToPoint(
        Offset(0, size.height),
        radius: Radius.circular(size.width),
        clockwise: true,
      );
      path.lineTo(0, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
