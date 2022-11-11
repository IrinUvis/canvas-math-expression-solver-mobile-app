import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test Calculator", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.plus,
      MathSymbol.eight
    ];

    double result = calculator.calculate(expression);

    expect(result, 13.toDouble());
  });
}