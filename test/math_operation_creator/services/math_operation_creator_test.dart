import 'dart:ui';

import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/services/math_operation_creator.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/classifiers/math_symbol_classifier.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/models/symbol_prediction_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'math_operation_creator_test.mocks.dart';

@GenerateMocks([MathSymbolClassifier, Image])
void main() {
  final MathSymbolClassifier classifier = MockMathSymbolClassifier();
  final Image drawnSymbol = MockImage();

  group('test math operation creator', () {
    test('object initialized correctly', () async {
      final creator = await MathOperationCreator.create(classifier);

      expect(creator.operation.operationElements, []);
      expect(creator.operation.result, 0.0);
    });

    test('symbols are added correctly', () async {
      when(classifier.classify(drawnSymbol)).thenAnswer((_) async {
        return SymbolPredictionDetails(
          symbol: MathSymbol.five.toString(),
          predictionProbability: 0.8,
        );
      });

      final creator = await MathOperationCreator.create(classifier);
      await creator.addMathSymbol(drawnSymbol);

      expect(creator.operation.operationElements, [MathSymbol.five]);
      expect(creator.operation.result, 0.0); // TODO: Napraw tu Artur pls :)
    });

    test('symbols are added correctly', () async {
      when(classifier.classify(drawnSymbol)).thenAnswer((_) async {
        return SymbolPredictionDetails(
          symbol: MathSymbol.five.toString(),
          predictionProbability: 0.8,
        );
      });

      final creator = await MathOperationCreator.create(classifier);
      await creator.addMathSymbol(drawnSymbol);

      expect(creator.operation.operationElements, [MathSymbol.five]);
      expect(creator.operation.result, 0.0); // TODO: Napraw tu Artur pls :)

      creator.clearOperation();

      expect(creator.operation.operationElements, []);
      expect(creator.operation.result, 0.0);
    });

    test('dispose() disposes classifier', () async {
      final creator = await MathOperationCreator.create(classifier);

      creator.dispose();

      verify(classifier.close()).called(1);
    });
  });
}
