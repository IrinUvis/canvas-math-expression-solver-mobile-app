import 'dart:ui';

import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/math_symbol_creator/models/math_symbol.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/classifiers/math_symbol_classifier.dart';

class MathSymbolCreator {
  MathSymbolCreator._create({
    required MathSymbolClassifier mathSymbolClassifier,
  }) : _mathSymbolClassifier = mathSymbolClassifier;

  static Future<MathSymbolCreator> create({
    MathSymbolClassifier? classifier,
    required Calculator calculator,
  }) async {
    final mathSymbolClassifier = classifier ?? await MathSymbolClassifier.create();
    return MathSymbolCreator._create(
      mathSymbolClassifier: mathSymbolClassifier,
    );
  }

  final MathSymbolClassifier _mathSymbolClassifier;

  Future<MathSymbol> recogniseSymbol(Image drawnSymbol) async {
    final predictionDetails = await _mathSymbolClassifier.classify(drawnSymbol);
    return predictionDetails.symbol.toMathSymbol();
  }

  /// Has to be called!!!
  void dispose() {
    _mathSymbolClassifier.close();
  }
}
