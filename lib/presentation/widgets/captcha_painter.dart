import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_color.dart';

class CaptchaPainter extends CustomPainter {
  final String captchaText;
  final Random random = Random();

  CaptchaPainter(this.captchaText);

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = AppColor.grey2);

    // Noise lines
    for (int i = 0; i < 6; i++) {
      canvas.drawLine(
          Offset(random.nextDouble() * size.width,
              random.nextDouble() * size.height),
          Offset(random.nextDouble() * size.width,
              random.nextDouble() * size.height),
          Paint()
            ..color = AppColor.primary.withOpacity(0.5)
            ..strokeWidth = 1);
    }

    // Noise circles
    for (int i = 0; i < 15; i++) {
      canvas.drawCircle(
          Offset(random.nextDouble() * size.width,
              random.nextDouble() * size.height),
          random.nextDouble() * 4,
          Paint()..color = AppColor.primary.withOpacity(0.3));
    }

    // Centered text rendering
    final textStyle = GoogleFonts.specialElite(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.primary,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: captchaText, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: size.width);
    final offset = Offset((size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
