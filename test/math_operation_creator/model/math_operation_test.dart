import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_operation.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MathOperation tests', () {
    test('creation', () {
      const operation = MathOperation(operationElements: [], result: 0.0);

      expect(operation.operationElements, []);
      expect(operation.result, 0.0);
    });

    test('equality', () {
      const operation1 = MathOperation(operationElements: [MathSymbol.eight], result: 8.0);
      const operation2 = MathOperation(operationElements: [MathSymbol.five], result: 5.0);
      const operation3 = MathOperation(operationElements: [MathSymbol.eight], result: 8.0);

      expect(operation1 == operation2, false);
      expect(operation1 == operation3, true);
    });
  });
}