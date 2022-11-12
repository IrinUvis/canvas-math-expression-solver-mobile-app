import 'package:canvas_equation_solver_mobile_app/calculator/expression_validator.dart';
import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:stack/stack.dart';

class Calculator {
  List<String> digits = ['0', '1', '2', '2', '3', '4', '5', '6', '7', '8', '9'];
  ExpressionValidator expressionValidator = ExpressionValidator();

  double calculate(List<MathSymbol> operationElements) {
    String expression = "";
    for (MathSymbol element in operationElements) {
      expression += element.toString();
    }

    Stack<double> values = Stack();

    Stack<String> operators = Stack();

    expressionValidator.performValidation(expression);

    for (int i = 0; i < expression.length; i++) {
      // Current character is a digit
      if (_isDigit(expression[i])) {
        String numberDigits = '';
        while (i < expression.length && _isDigit(expression[i])) {
          numberDigits += expression[i++];
        }
        values.push(double.parse(numberDigits));
        i--;
      }

      // Opening brace
      else if (expression[i] == '[') {
        operators.push(expression[i]);
      }

      // Closing brace
      else if (expression[i] == ']') {
        while (operators.top() != '[') {}
      }

      // Operator
      else if (expression[i] == '+' ||
                expression[i] == '-' ||
                expression[i] == '*' ||
                expression[i] == '/') {
        while (operators.isNotEmpty &&
                _hasPrecedence(expression[i], operators.top())) {
          values.push(_applyOperation(operators.pop(), values.pop(), values.pop()));
        }
        operators.push(expression[i]);
      }
    }

    while (operators.isNotEmpty) {
      values.push(_applyOperation(operators.pop(), values.pop(), values.pop()));
    }

    return values.pop();
  }

  bool _hasPrecedence(String op1, String op2) {
    if (op2 == '[' || op2 == ']') {
      return false;
    }
    if ((op1 == '*' || op1 == '/') && (op2 == '+' || op2 == '-')) {
      return false;
    } else {
      return true;
    }
  }

  double _applyOperation(String op, double a, double b) {
    switch (op) {
      case '+':
        {
          return a + b;
        }
      case '-':
        {
          return a - b;
        }
      case '*':
        {
          return a * b;
        }
      case '/':
        {
          if (b == 0) {
            throw Exception("Cannot divide by zero");
          }
          return a / b;
        }
    }
    return 0;
  }

  bool _isDigit(String character) => digits.contains(character);
}
