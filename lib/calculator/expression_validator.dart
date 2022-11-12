import 'package:canvas_equation_solver_mobile_app/calculator/exception/calculator_exception.dart';
import 'package:stack/stack.dart';

class ExpressionValidator {

  String performValidation(String expression) {
    String returnExpression;
    _validateBracketsNumber(expression);
    _validateBracketsPairing(expression);
    returnExpression = _checkSymbolBeforeOpeningBrackets(expression);
    _validateNoOperatorAtExpressionBeginning(expression);
    _validateNoOperatorAtExpressionEnd(expression);
    _validateNoTwoOperatorsSideBySideAnywhere(expression);
    return returnExpression;
  }

  // Throw an exception if the expression contains an odd number of brackets
  void _validateBracketsNumber(String expression) {
    int bracketsSum = 0;
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '[' || expression[i] == ']') bracketsSum += 1;
    }
    if (bracketsSum % 2 != 0) throw CalculatorException("The number of brackets in the expression needs to be even");
  }

  // Throw an exception if not every opening bracket has its corresponding closing bracket and vice versa
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

  // If there is no operator (+, -, *, /) before the opening bracket, a multiplication operator (*)
  // is added so that the calculating function is able to calculate an expression value
  String _checkSymbolBeforeOpeningBrackets(String expression) {
    // stack used to check what is the first symbol before the opening bracket
    Stack<String> symbols = Stack();
    // loop through each expression symbol
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '[' && symbols.isNotEmpty) {
        // if we are at the opening bracket
        // and there is no operator
        if (symbols.top() != '+' && symbols.top() != '-' && symbols.top() != '*' && symbols.top() != '/') {
          String firstPart = "";
          String secondPart = "";
          // split the expression into the part before and after the bracket
          for (int j = 0; j < i; j++) {
            firstPart += expression[j];
          }
          for (int j = i + 1; j < expression.length; j++) {
            secondPart += expression[j];
          }
          // combine it again with adding the multiplication opetator before the opening bracket
          expression = "$firstPart*[$secondPart";
          symbols.push("*");
          // increase i because the expression.length has increased by one
          i++;
          symbols.push(expression[i]);
        }
      } else {
        symbols.push(expression[i]);
      }
    }
    return expression;
  }
  
  void _validateNoOperatorAtExpressionBeginning(String expression) {
    if (expression.startsWith('+') || expression.startsWith('-') || expression.startsWith('*') || expression.startsWith('/')) {
      throw CalculatorException('An expression cannot start with an operator');
    }
  }

  void _validateNoOperatorAtExpressionEnd(String expression) {
    if (expression.endsWith('+') || expression.endsWith('-') || expression.endsWith('*') || expression.endsWith('/')) {
      throw CalculatorException('An expression cannot start with an operator');
    }
  }

  void _validateNoTwoOperatorsSideBySideAnywhere(String expression) {
    Stack<String> symbols = Stack();
    for (int i = 0; i < expression.length; i++) {
      if (symbols.isNotEmpty && _isOperator(symbols.top()) && _isOperator(expression[i])) {
        throw CalculatorException("There can be no two operators (+, -, *, /) side by side anywhere");
      }
    }
  }

  bool _isOperator(String symbol) {
    return symbol == '+' || symbol == '-' || symbol == '*' || symbol == '/';
  }
}