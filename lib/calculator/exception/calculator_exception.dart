class CalculatorException implements Exception {
  String message;

  CalculatorException(this.message);

  @override
  String toString() {
    return message;
  }
}