import 'dart:ui';

import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/services/math_symbol_creator.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/classifiers/math_symbol_classifier.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/models/symbol_prediction_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'math_operation_creator_test.mocks.dart';

@GenerateMocks([MathSymbolClassifier, Image, Calculator])
void main() {
  final MathSymbolClassifier classifier = MockMathSymbolClassifier();
  final Calculator calculator = MockCalculator();
  final Image drawnSymbol = MockImage();

  // group('test math operation creator', () {
  //   test('object initialized correctly', () async {
  //     final creator = await MathSymbolCreator.create(
  //       classifier: classifier,
  //       calculator: calculator,
  //     );

  //     // expect(creator.operation.operationElements, []);
  //     // expect(creator.operation.result, 0.0);
  //   });

    // test('symbols are added correctly', () async {
    //   when(classifier.classify(drawnSymbol)).thenAnswer((_) async {
    //     return SymbolPredictionDetails(
    //       symbol: MathSymbol.five.toString(),
    //       predictionProbability: 0.8,
    //     );
    //   });
    //   when(calculator.calculate([MathSymbol.five])).thenReturn(5.0);

    //   final creator = await MathSymbolCreator.create(
    //     classifier: classifier,
    //     calculator: calculator,
    //   );
    //   // await creator.addMathSymbol(drawnSymbol);

    //   // expect(creator.operation.operationElements, [MathSymbol.five]);
    //   // expect(creator.operation.result, 5.0);
    // });

    test('Symbol is recognised', () async {
      when(classifier.classify(drawnSymbol)).thenAnswer((_) async {
        return SymbolPredictionDetails(
          symbol: MathSymbol.five.toString(),
          predictionProbability: 0.8,
        );
      });
      when(calculator.calculate([MathSymbol.five])).thenReturn(5.0);

      final creator = await MathSymbolCreator.create(
        classifier: classifier,
        calculator: calculator,
      );
      final result = await creator.recogniseSymbol(drawnSymbol);

      expect(result, MathSymbol.five);
    });

    test('dispose() disposes classifier', () async {
      final creator = await MathSymbolCreator.create(
        classifier: classifier,
        calculator: calculator,
      );

      creator.dispose();

      verify(classifier.close()).called(1);
    });
  });
}
