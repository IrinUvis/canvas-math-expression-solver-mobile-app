import 'dart:ui';
import 'package:canvas_equation_solver_mobile_app/canvas/models/drawn_line.dart';
import 'package:canvas_equation_solver_mobile_app/canvas/widgets/app_drawer.dart';
import 'package:canvas_equation_solver_mobile_app/canvas/widgets/equation_symbols_widget.dart';
import 'package:canvas_equation_solver_mobile_app/providers/equation_result_provider.dart';
import 'package:canvas_equation_solver_mobile_app/providers/user_input_provider.dart';
import 'package:canvas_equation_solver_mobile_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/drawing_area.dart';

class CanvasScreen extends ConsumerStatefulWidget {
  const CanvasScreen({Key? key}) : super(key: key);

  static const horizontalPadding = 16.0;
  static const strokeWidth = 20.0;

  @override
  ConsumerState<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends ConsumerState<CanvasScreen> {
  // State
  DrawnLine? currentlyDrawnLine;
  List<DrawnLine> allDrawnLines = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canvasSize = MediaQuery.of(context).size.width - 2 * CanvasScreen.horizontalPadding;
    final equationResult = ref.watch(equationResultProvider);

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
              _sendDrawnSymbolToMathOperationCreator(canvasSize);
            },
            icon: const Icon(Icons.calculate),
          ),
          IconButton(
            onPressed: () {
              // TODO: Add sharing funcitonality
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              ref.read(userInputProvider.notifier).deleteAll();
              _onCanvasCleared();
            },
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
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
              // operation.operationElements.isNotEmpty ? Text(operation.operationElements.last.toString()) : const SizedBox(),
              SizedBox(width: canvasSize, height: canvasSize / 2, child: const EquationSymbolsWidget()),
              equationResult.fold((l) {
                return Center(
                  child: Text(
                    l.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.deepOrangeAccent),
                  ),
                );
              }, (r) {
                return Center(
                  child: Text(
                    "= ${r.toString()}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.orange),
                  ),
                );
              }),
            ],
          ),
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
  Future<void> _sendDrawnSymbolToMathOperationCreator(double canvasSize) async {
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
    ref.read(userInputProvider.notifier).addSymbolFromImage(image);

    _onCanvasCleared();
  }

  /// Method to be called in order to clear the canvas completely.
  void _onCanvasCleared() {
    setState(() {
      currentlyDrawnLine = null;
      allDrawnLines = [];
    });
  }
}
