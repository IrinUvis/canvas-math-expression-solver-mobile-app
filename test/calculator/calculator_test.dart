import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("7", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.seven
    ];

    double result = calculator.calculate(expression);

    expect(result, 7.toDouble());
  });

  test("5+8", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.plus,
      MathSymbol.eight
    ];

    double result = calculator.calculate(expression);

    expect(result, 13.toDouble());
  });

  test("7-2", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.seven,
      MathSymbol.minus,
      MathSymbol.two
    ];

    double result = calculator.calculate(expression);

    expect(result, 5.toDouble());
  });

  test("7-9", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.seven,
      MathSymbol.minus,
      MathSymbol.nine
    ];

    double result = calculator.calculate(expression);

    expect(result, -2.toDouble());
  });

  test("2*8", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.two,
      MathSymbol.multiply,
      MathSymbol.eight
    ];

    double result = calculator.calculate(expression);

    expect(result, 16.toDouble());
  });

  test("8/2", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.eight,
      MathSymbol.division,
      MathSymbol.two
    ];

    double result = calculator.calculate(expression);

    expect(result, 4.toDouble());
  });

  test("2/8", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.two,
      MathSymbol.division,
      MathSymbol.eight
    ];

    double result = calculator.calculate(expression);

    expect(result, 0.25.toDouble());
  });

  test("3*2+5*(6-2)", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.three,
      MathSymbol.multiply,
      MathSymbol.two,
      MathSymbol.plus,
      MathSymbol.five,
      MathSymbol.multiply,
      MathSymbol.openingBracket,
      MathSymbol.six,
      MathSymbol.minus,
      MathSymbol.two,
      MathSymbol.closingBracket
    ];

    double result = calculator.calculate(expression);

    expect(result, 26.toDouble());
  });

  test("5(8+7)", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.openingBracket,
      MathSymbol.eight,
      MathSymbol.plus,
      MathSymbol.seven,
      MathSymbol.closingBracket
    ];

    double result = calculator.calculate(expression);

    expect(result, 75.toDouble());
  });
}