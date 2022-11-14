import 'dart:ui';

import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_operation.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/classifiers/math_symbol_classifier.dart';

class MathOperationCreator {
  MathOperationCreator._create({
    required MathSymbolClassifier mathSymbolClassifier,
    required this.operation,
  }) : _mathSymbolClassifier = mathSymbolClassifier;

  static Future<MathOperationCreator> create(
    MathSymbolClassifier? classifier,
  ) async {
    final mathSymbolClassifier = classifier ?? await MathSymbolClassifier.create();
    const operation = MathOperation(
      operationElements: [],
      result: 0,
    );
    return MathOperationCreator._create(
      mathSymbolClassifier: mathSymbolClassifier,
      operation: operation,
    );
  }

  final MathSymbolClassifier _mathSymbolClassifier;

  MathOperation operation;

  Calculator calculator = Calculator();

  Future<void> addMathSymbol(Image drawnSymbol) async {
    final predictionDetails = await _mathSymbolClassifier.classify(drawnSymbol);

    List<MathSymbol> operationElements = List.of(operation.operationElements)
      ..add(predictionDetails.symbol.toMathSymbol());
    double result = calculator.calculate(operationElements);

    operation = MathOperation(
      operationElements: operationElements,
      result: result,
    );
  }

  void clearOperation() {
    operation = const MathOperation(
      operationElements: [],
      result: 0,
    );
  }

  /// Has to be called!!!
  void dispose() {
    _mathSymbolClassifier.close();
  }
}
