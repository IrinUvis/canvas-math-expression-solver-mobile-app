import 'dart:ui';

import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/calculator/exception/calculator_exception.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_operation.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/classifiers/math_symbol_classifier.dart';

class MathOperationCreator {
  MathOperationCreator._create({
    required MathSymbolClassifier mathSymbolClassifier,
    required Calculator calculator,
    required this.operation,
  })  : _mathSymbolClassifier = mathSymbolClassifier,
        _calculator = calculator;

  static Future<MathOperationCreator> create({
    MathSymbolClassifier? classifier,
    required Calculator calculator,
  }) async {
    final mathSymbolClassifier = classifier ?? await MathSymbolClassifier.create();
    const operation = MathOperation(
      operationElements: [],
      result: 0,
    );
    return MathOperationCreator._create(
      mathSymbolClassifier: mathSymbolClassifier,
      calculator: calculator,
      operation: operation,
    );
  }

  final MathSymbolClassifier _mathSymbolClassifier;
  final Calculator _calculator;
  MathOperation operation;

  Future<void> addMathSymbol(Image drawnSymbol) async {
    final predictionDetails = await _mathSymbolClassifier.classify(drawnSymbol);

    List<MathSymbol> operationElements = List.of(operation.operationElements)..add(predictionDetails.symbol.toMathSymbol());

    try {
      double result = _calculator.calculate(operationElements);

      operation = MathOperation(
        operationElements: operationElements,
        result: result,
      );
    } on CalculatorException catch (e) {
      operation = MathOperation(
        operationElements: operationElements,
        result: operation.result,
        errorMessage: e.message,
      );
    }
  }

  Future<MathSymbol> recogniseSymbol(Image drawnSymbol) async {
    final predictionDetails = await _mathSymbolClassifier.classify(drawnSymbol);
    return predictionDetails.symbol.toMathSymbol();
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
