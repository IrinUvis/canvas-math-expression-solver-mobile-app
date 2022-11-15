import 'dart:ui';
import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/canvas/models/drawn_line.dart';
import 'package:canvas_equation_solver_mobile_app/canvas/widgets/app_drawer.dart';
import 'package:canvas_equation_solver_mobile_app/canvas/widgets/number_container.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_operation.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/services/math_operation_creator.dart';
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
  late final MathOperationCreator _mathOperationCreator;

  // State
  DrawnLine? currentlyDrawnLine;
  List<DrawnLine> allDrawnLines = [];
  MathOperation operation = const MathOperation(
    operationElements: [],
    result: 0.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeMathOperationCreator();
  }

  Future<void> _initializeMathOperationCreator() async {
    _mathOperationCreator = await MathOperationCreator.create(
      classifier: null,
      calculator: Calculator(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mathOperationCreator.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canvasSize = MediaQuery.of(context).size.width - 2 * CanvasScreen.horizontalPadding;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _updateOperationFromCurrentDrawing(canvasSize);
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: _onCanvasCleared,
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      drawer: const AppDrawer(),
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
              strokeColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
              strokeWidth: CanvasScreen.strokeWidth,
            ),
            const SizedBox(height: 10),
            operation.operationElements.isNotEmpty ? Text(operation.operationElements.last.toString()) : const SizedBox(),
            Text(operation.result.toString()),
            operation.errorMessage != null ? Text(operation.errorMessage!) : const SizedBox(),
            Row(
              children: const [
                SymbolContainer(symbol: '2'),
                SymbolContainer(symbol: '1'),
                SymbolContainer(symbol: ':'),
                SymbolContainer(symbol: '3'),
                SymbolContainer(symbol: '7'),
              ],
            )
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

  /// Method to be called to update state of the operation, based on the currently drawn symbol.
  /// The parameter is the size of the canvas, on which the user is drawing.
  Future<void> _updateOperationFromCurrentDrawing(double canvasSize) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final lines = allDrawnLines;
    const strokeWidth = CanvasScreen.strokeWidth;
    final size = canvasSize.toInt();

    canvas.drawColor(Colors.white, BlendMode.src);

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < lines.length; ++i) {
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(size, size);
    await _mathOperationCreator.addMathSymbol(image);
    setState(() {
      operation = _mathOperationCreator.operation;
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
