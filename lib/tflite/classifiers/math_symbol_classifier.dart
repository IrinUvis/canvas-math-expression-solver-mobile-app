import 'dart:ui';

import 'package:canvas_equation_solver_mobile_app/tflite/models/symbol_prediction_details.dart';
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
    final libImg = img_lib.decodeImage(byteData!.buffer.asUint8List().toList());
    final resizedImg = img_lib.copyResize(
      libImg!,
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
    print("Drawing:");
    for(final row in input) {
      print(row.map((e) => e.toInt()).toList());
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
    final predictedSymbol = orderedLabels[result.indexOf(highestPredictionProbability)];
    print("Predicted symbol: $predictedSymbol");
    print("Probability: $highestPredictionProbability");

    return SymbolPredictionDetails(
      symbol: predictedSymbol,
      predictionProbability: highestPredictionProbability,
    );
  }
}
