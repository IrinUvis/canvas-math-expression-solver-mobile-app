import 'package:canvas_equation_solver_mobile_app/tflite/models/symbol_prediction_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SymbolPredictionDetails tests', () {
    test('creation', () {
      const details = SymbolPredictionDetails(
        symbol: '5',
        predictionProbability: 0.8,
      );

      expect(details.symbol, '5');
      expect(details.predictionProbability, 0.8);
    });

    test('equality', () {
      const details1 = SymbolPredictionDetails(
        symbol: '5',
        predictionProbability: 0.8,
      );
      const details2 = SymbolPredictionDetails(
        symbol: '[',
        predictionProbability: 0.8,
      );
      const details3 = SymbolPredictionDetails(
        symbol: '5',
        predictionProbability: 0.8,
      );

      expect(details1 == details2, false);
      expect(details1 == details3, true);
    });
  });
}
