import 'package:canvas_equation_solver_mobile_app/canvas/models/drawn_line.dart';
import 'package:canvas_equation_solver_mobile_app/theme/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/drawing_area.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({Key? key}) : super(key: key);

  static const horizontalPadding = 16.0;
  static const strokeWidth = 20.0;

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  DrawnLine? currentlyDrawnLine;
  List<DrawnLine> allDrawnLines = [];

  @override
  Widget build(BuildContext context) {
    final canvasSize =
        MediaQuery.of(context).size.width - 2 * CanvasScreen.horizontalPadding;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: _onCanvasCleared,
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: CanvasScreen.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                'Equation drawing canvas',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: orange200,
                    ),
              ),
            ),
            const SizedBox(height: 4.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                'Draw each symbol separately',
              ),
            ),
            const SizedBox(height: 8.0),
            DrawingArea(
              width: canvasSize,
              height: canvasSize,
              onPanStart: (details) => _onPanStart(details, context),
              onPanUpdate: (details) => _onPanUpdate(details, context),
              onPanEnd: (details) => _onPanEnd(details, context),
              currentlyDrawnLine: currentlyDrawnLine,
              allDrawnLines: allDrawnLines,
              strokeColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              strokeWidth: CanvasScreen.strokeWidth,
            ),
          ],
        ),
      ),
    );
  }

  /// Method to be called as onPanStart callback from [GestureDetector].
  void _onPanStart(DragStartDetails details, BuildContext context) {
    final point = details.localPosition;
    final line = DrawnLine(path: [point]);
    setState(() {
      currentlyDrawnLine = line;
    });
  }

  /// Method to be called as onPanUpdate callback from [GestureDetector].
  void _onPanUpdate(DragUpdateDetails details, BuildContext context) {
    final point = details.localPosition;
    final path = List.of(currentlyDrawnLine!.path)..add(point);
    setState(() {
      currentlyDrawnLine = DrawnLine(path: path);
    });
  }

  /// Method to be called as onPanEnd callback from [GestureDetector].
  void _onPanEnd(DragEndDetails details, BuildContext context) {
    final drawnLines = List.of(allDrawnLines);
    drawnLines.add(currentlyDrawnLine!);
    setState(() {
      currentlyDrawnLine = null;
      allDrawnLines = drawnLines;
    });
  }

  /// Method to be called in order to clear the canvas completely.
  void _onCanvasCleared() {
    setState(() {
      currentlyDrawnLine = null;
      allDrawnLines = [];
    });
  }
}
