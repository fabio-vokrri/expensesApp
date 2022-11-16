import "dart:math" show pi;

import "package:flutter/material.dart";

class OverviewProgressBar extends CustomPainter {
  final double percentage;
  final Color color;
  final Color backgroundColor;

  OverviewProgressBar({
    required this.percentage,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = color;

    double percentageToRadians(double percentage) {
      return (percentage * 2 * pi) / 100;
    }

    final Paint paint2 = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = backgroundColor;

    final Path percentagePath = Path()
      ..arcTo(
        Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2),
          width: size.width,
          height: size.height,
        ),
        3 * pi / 2,
        percentageToRadians(percentage),
        false,
      );

    canvas.drawCircle(
      Offset(size.height / 2, size.width / 2),
      size.width / 2,
      paint2,
    );
    canvas.drawPath(percentagePath, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
