import 'package:canvas_equation_solver_mobile_app/calculator/exception/calculator_exception.dart';
import 'package:stack/stack.dart';

class ExpressionValidator {

  void performValidation(String expression) {
    _validateBracketsNumber(expression);
    _validateBracketsPairing(expression);
  }

  void _validateBracketsNumber(String expression) {
    int bracketsSum = 0;
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '[' || expression[i] == ']') bracketsSum += 1;
    }
    if (bracketsSum % 2 != 0) throw CalculatorException("The number of brackets in the expression needs to be even. ");
  }

  void _validateBracketsPairing(String expression) {
    Stack<String> brackets = Stack();
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '[') {
        brackets.push('[');
      } else if (expression[i] == ']' && brackets.isNotEmpty) {
        brackets.pop();
      } else if (expression[i] == ']' && brackets.isEmpty) {
        throw CalculatorException("Some closing bracket might not have a corresponding opening bracket");
      }
    }
    if (brackets.isNotEmpty) throw CalculatorException("Some opening bracket might not have a corresponding closing bracket");
  }

  void _checkSymbolBeforeOpeningBrackets(String expression) {
    Stack<String> symbols = Stack();
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] != '[') {

      }
    }
  }
}