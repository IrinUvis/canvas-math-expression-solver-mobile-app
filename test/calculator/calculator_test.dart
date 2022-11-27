import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/calculator/exception/calculator_exception.dart';
import 'package:canvas_equation_solver_mobile_app/math_symbol_creator/models/math_symbol.dart';
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

  test("(354)", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.openingBracket,
      MathSymbol.three,
      MathSymbol.five,
      MathSymbol.four,
      MathSymbol.closingBracket
    ];

    double result = calculator.calculate(expression);

    expect(result, 354.toDouble());
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

  test("3/7", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.three,
      MathSymbol.division,
      MathSymbol.seven
    ];

    double result = calculator.calculate(expression);

    expect(result, 0.43.toDouble());
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

  test("5*(3-2(2-2))", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.multiply,
      MathSymbol.openingBracket,
      MathSymbol.three,
      MathSymbol.minus,
      MathSymbol.two,
      MathSymbol.openingBracket,
      MathSymbol.two,
      MathSymbol.minus,
      MathSymbol.two,
      MathSymbol.closingBracket,
      MathSymbol.closingBracket
    ];

    double result = calculator.calculate(expression);

    expect(result, 15.toDouble());
  });

  test("3/0", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.three,
      MathSymbol.division,
      MathSymbol.zero
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
        e.message == "Cannot divide by zero")));
  });

  test("5*(3-2", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.multiply,
      MathSymbol.openingBracket,
      MathSymbol.three,
      MathSymbol.minus,
      MathSymbol.two
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
        e.message == "Some opening bracket might not have a corresponding closing bracket")));
  });

  test("5*3-2)", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.multiply,
      MathSymbol.three,
      MathSymbol.minus,
      MathSymbol.two,
      MathSymbol.closingBracket
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
            e.message == "Some closing bracket might not have a corresponding opening bracket")));
  });

  test("5*(3-2(2-2)", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.multiply,
      MathSymbol.openingBracket,
      MathSymbol.three,
      MathSymbol.minus,
      MathSymbol.two,
      MathSymbol.openingBracket,
      MathSymbol.two,
      MathSymbol.minus,
      MathSymbol.two,
      MathSymbol.closingBracket
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
            e.message == "Some opening bracket might not have a corresponding closing bracket")));
  });

  test("+5-2", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.plus,
      MathSymbol.five,
      MathSymbol.minus,
      MathSymbol.two
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
            e.message == "An expression cannot start with an operator (+, -, *, /)")));
  });

  test("5-2*", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.minus,
      MathSymbol.two,
      MathSymbol.multiply
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
            e.message == "An expression cannot end with an operator (+, -, *, /)")));
  });

  test("5-+2", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.five,
      MathSymbol.minus,
      MathSymbol.plus,
      MathSymbol.two
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
            e.message == "There can be no two operators (+, -, *, /) side by side anywhere")));
  });

  test("(*5)", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.openingBracket,
      MathSymbol.multiply,
      MathSymbol.five,
      MathSymbol.closingBracket
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
            e.message == "There cannot be an operator just after the opening bracket")));
  });

  test("(7/)", () {
    final calculator = Calculator();

    List<MathSymbol> expression = [
      MathSymbol.openingBracket,
      MathSymbol.seven,
      MathSymbol.division,
      MathSymbol.closingBracket
    ];

    expect(() => calculator.calculate(expression),
        throwsA(predicate((e) =>
        e is CalculatorException &&
            e.message == "There cannot be an operator just before the closing bracket")));
  });
}