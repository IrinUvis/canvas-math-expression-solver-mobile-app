import 'package:canvas_equation_solver_mobile_app/calculator/exception/calculator_exception.dart';
import 'package:stack/stack.dart';

class ExpressionValidator {

  String performValidation(String expression) {
    String returnExpression;
    _validateBracketsNumber(expression);
    _validateBracketsPairing(expression);
    returnExpression = _checkSymbolBeforeOpeningBrackets(expression);
    return returnExpression;
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

  String _checkSymbolBeforeOpeningBrackets(String expression) {
    Stack<String> symbols = Stack();
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '[' && symbols.isNotEmpty) {
        if (symbols.top() != '+' && symbols.top() != '-' && symbols.top() != '*' && symbols.top() != '/') {
          String firstPart = "";
          String secondPart = "";
          for (int j = 0; j < i; j++) {
            firstPart += expression[j];
          }
          for (int j = i + 1; j < expression.length; j++) {
            secondPart += expression[j];
          }
          expression = "$firstPart*[$secondPart";
          symbols.push("*");
          i++;
          symbols.push(expression[i]);
        }
      } else {
        symbols.push(expression[i]);
      }
    }
    return expression;
  }
}