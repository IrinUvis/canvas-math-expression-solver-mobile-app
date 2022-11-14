import 'dart:math';
import 'dart:ui';

import 'package:canvas_equation_solver_mobile_app/tflite/models/symbol_prediction_details.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img_lib;
import 'package:tflite_flutter/tflite_flutter.dart';

class MathSymbolClassifier {
  MathSymbolClassifier._create({
    required this.interpreter,
  });

  static const orderedLabels = [
    '%',
    '*',
    '+',
    '-',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '[',
    ']',
  ];

  static Future<MathSymbolClassifier> create() async {
    final interpreter = await Interpreter.fromAsset(_modelFileName);

    final classifier = MathSymbolClassifier._create(
      interpreter: interpreter,
    );
    return classifier;
  }

  static const _modelFileName =
      'ai_model/handwritten_math_symbol_classification.tflite';

  final Interpreter interpreter;

  Future<SymbolPredictionDetails> classify(Image image) async {
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final libImg =
        img_lib.decodeImage(byteData!.buffer.asUint8List().toList())!;

    int left = (libImg.width - 1) ~/ 2;
    int top = (libImg.height - 1) ~/ 2;
    int right = left;
    int bottom = top;
    for (int x = 0; x < libImg.width; x++) {
      for (int y = 0; y < libImg.height; y++) {
        if (libImg.getPixel(x, y) != 4294967295) {
          left = min(left, x);
          top = min(top, y);
          right = max(right, x);
          bottom = max(bottom, y);
        }
      }
    }

    int leftCrop = left;
    int topCrop = top;
    int rightCrop = libImg.width - right;
    int bottomCrop = libImg.height - bottom;

    final orderedBoundaryCoordinates =
        List.of([leftCrop, topCrop, rightCrop, bottomCrop])..sort();
    final minVal = orderedBoundaryCoordinates[0];
    final maxCrop = (1.5 * minVal).toInt();
    if (leftCrop > maxCrop) leftCrop = maxCrop;
    if (topCrop > maxCrop) topCrop = maxCrop;
    if (rightCrop > maxCrop) rightCrop = maxCrop;
    if (bottomCrop > maxCrop) bottomCrop = maxCrop;

    final croppedImg = img_lib.copyCrop(
      libImg,
      leftCrop,
      topCrop,
      libImg.width - rightCrop - leftCrop,
      libImg.height - bottomCrop - topCrop,
    );

    final resizedImg = img_lib.copyResize(
      croppedImg,
      width: 28,
      height: 28,
      interpolation: img_lib.Interpolation.average,
    );

    List<List<double>> input = [];
    List<double> tempYPixels = [];
    for (int y = 0; y < resizedImg.height; y++) {
      for (int x = 0; x < resizedImg.width; x++) {
        final pixel = resizedImg.getPixel(x, y);
        final string = pixel.toRadixString(16);
        final oneChannel = string.substring(6);
        final val = int.parse(oneChannel, radix: 16);
        tempYPixels.add(val == 255 ? 0 : 1);
      }
      input.add(List.of(tempYPixels));
      tempYPixels.clear();
    }

    final output = List.filled(16, 0).reshape([1, 16]);
    if (kDebugMode) {
      print("Drawing:");
      for (final row in input) {
        print(row.map((e) => e.toInt()).toList());
      }
    }

    interpreter.run(input, output);

    return _getPredictionDetailsFromOutput(output);
  }

  void close() {
    interpreter.close();
  }

  SymbolPredictionDetails _getPredictionDetailsFromOutput(
      List<dynamic> output) {
    final result = output[0] as List<double>;
    final sortedResult = List.of(result)..sort();
    final highestPredictionProbability = sortedResult[sortedResult.length - 1];
    final predictedSymbol =
        orderedLabels[result.indexOf(highestPredictionProbability)];
    if (kDebugMode) {
      print("Predicted symbol: $predictedSymbol");
      print("Probability: $highestPredictionProbability");
    }

    return SymbolPredictionDetails(
      symbol: predictedSymbol,
      predictionProbability: highestPredictionProbability,
    );
  }
}
