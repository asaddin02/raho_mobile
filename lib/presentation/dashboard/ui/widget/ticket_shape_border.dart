import 'package:flutter/material.dart';

class TicketShapeBorder extends ShapeBorder {
  final double radius;
  final Color color;

  const TicketShapeBorder({this.radius = 8, this.color = Colors.white});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    path.moveTo(rect.left, rect.top);

    path.lineTo(rect.right, rect.top);

    path.lineTo(rect.right, rect.bottom);

    path.lineTo(rect.left, rect.bottom);

    path.addOval(
      Rect.fromCircle(
        center: Offset(rect.left, rect.center.dy),
        radius: radius,
      ),
    );

    path.addOval(
      Rect.fromCircle(
        center: Offset(rect.right, rect.center.dy),
        radius: radius,
      ),
    );

    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()..color = color;
    final shapePath = getOuterPath(rect);
    canvas.drawPath(shapePath, paint);
  }

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }
}
