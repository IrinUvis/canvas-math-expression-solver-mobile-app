import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MathSymbol tests', () {
    test('toString() for correct values', () {
      final symbolStrings = [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '+',
        '-',
        '*',
        '/',
        '[',
        ']',
      ];

      final symbols = symbolStrings.map((str) => str.toMathSymbol()).toList();

      expect(symbols.length, symbolStrings.length);

      for (int i = 0; i < symbols.length; i++) {
        expect(symbols[i].toString(), symbolStrings[i]);
      }
    });

    test('toString() for unknown value', () {
      const symbolString = 'whatever';

      final unknownSymbol = symbolString.toMathSymbol();

      expect(unknownSymbol.toString(), 'unknown');
    });
  });
}