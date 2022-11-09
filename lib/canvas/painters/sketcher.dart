import 'package:flutter/material.dart';

import '../models/drawn_line.dart';

/// A [CustomPainter] implementation for drawing initiated by user.
class Sketcher extends CustomPainter {
  Sketcher({
    required this.lines,
    required this.strokeColor,
    required this.strokeWidth,
  });

  final List<DrawnLine> lines;
  final Color strokeColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    for (int i = 0; i < lines.length; ++i) {
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}