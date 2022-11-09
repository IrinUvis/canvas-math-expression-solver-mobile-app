import 'package:flutter/material.dart';

import '../models/drawn_line.dart';
import '../painters/sketcher.dart';

/// Canvas-like widget where user draws.
class DrawingArea extends StatelessWidget {
  const DrawingArea({
    Key? key,
    required this.width,
    required this.height,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.currentlyDrawnLine,
    required this.allDrawnLines,
    required this.strokeColor,
    required this.strokeWidth,
  }) : super(key: key);

  final double width;
  final double height;
  final void Function(DragStartDetails) onPanStart;
  final void Function(DragUpdateDetails) onPanUpdate;
  final void Function(DragEndDetails) onPanEnd;
  final DrawnLine? currentlyDrawnLine;
  final List<DrawnLine> allDrawnLines;
  final Color strokeColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
            child: RepaintBoundary(
              child: Container(
                color: Colors.transparent,
                child: CustomPaint(
                  painter: Sketcher(
                    lines: currentlyDrawnLine != null
                        ? (List.of(allDrawnLines)..add(currentlyDrawnLine!))
                        : allDrawnLines,
                    strokeColor: strokeColor,
                    strokeWidth: strokeWidth,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}