import 'package:canvas_equation_solver_mobile_app/calculator/exception/calculator_exception.dart';
import 'package:canvas_equation_solver_mobile_app/calculator/expression_validator.dart';
import 'package:canvas_equation_solver_mobile_app/math_symbol_creator/models/math_symbol.dart';
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

    expression = expressionValidator.performValidation(expression);

    try {
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

        // Opening bracket
        else if (expression[i] == '[') {
          operators.push(expression[i]);
        }

        // Closing bracket
        else if (expression[i] == ']') {
          while (operators.top() != '[') {
            values.push(
                _applyOperation(
                    operators.pop(),
                    values.pop(),
                    values.pop()));
          }
          operators.pop();
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

      // When the expression's end is reached, its value is calculated
      while (operators.isNotEmpty) {
        values.push(_applyOperation(operators.pop(), values.pop(), values.pop()));
      }
    } on CalculatorException catch(e) {
      throw CalculatorException(e.message);
    } on Exception {
      throw CalculatorException("Unexpected error occurred");
    }

    // After all calculations the values stack should
    // contain only one number - the expression's value
    return double.parse(values.pop().toStringAsFixed(2));
  }

  // Check if operator 2 (op2) has precedence comparing to operator 1 (op1)
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

  // Perform the operation op on numbers a and b
  double _applyOperation(String op, double b, double a) {
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
            throw CalculatorException("Cannot divide by zero");
          }
          return a / b;
        }
    }
    return 0;
  }

  // Check if a given character is a number from range [0-9]
  bool _isDigit(String character) => digits.contains(character);
}
