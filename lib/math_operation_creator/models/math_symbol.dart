/// Enum class containing all symbols.
enum MathSymbol {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  plus,
  minus,
  multiply,
  division,
  openingBracket,
  closingBracket,
  unknown;

  @override
  String toString() {
    switch (this) {
      case MathSymbol.zero:
        return '0';
      case MathSymbol.one:
        return '1';
      case MathSymbol.two:
        return '2';
      case MathSymbol.three:
        return '3';
      case MathSymbol.four:
        return '4';
      case MathSymbol.five:
        return '5';
      case MathSymbol.six:
        return '6';
      case MathSymbol.seven:
        return '7';
      case MathSymbol.eight:
        return '8';
      case MathSymbol.nine:
        return '9';
      case MathSymbol.plus:
        return '+';
      case MathSymbol.minus:
        return '-';
      case MathSymbol.multiply:
        return '*';
      case MathSymbol.division:
        return '%';
      case MathSymbol.openingBracket:
        return '[';
      case MathSymbol.closingBracket:
        return ']';
      case MathSymbol.unknown:
        return 'unknown';
    }
  }
}

extension MathSymbolConversion on String {
  MathSymbol toMathSymbol() {
    switch (this) {
      case '0':
        return MathSymbol.zero;
      case '1':
        return MathSymbol.one;
      case '2':
        return MathSymbol.two;
      case '3':
        return MathSymbol.three;
      case '4':
        return MathSymbol.four;
      case '5':
        return MathSymbol.five;
      case '6':
        return MathSymbol.six;
      case '7':
        return MathSymbol.seven;
      case '8':
        return MathSymbol.eight;
      case '9':
        return MathSymbol.nine;
      case '+':
        return MathSymbol.plus;
      case '-':
        return MathSymbol.minus;
      case '*':
        return MathSymbol.multiply;
      case '%':
        return MathSymbol.division;
      case '[':
        return MathSymbol.openingBracket;
      case ']':
        return MathSymbol.closingBracket;
      default:
        return MathSymbol.unknown;
    }
  }
}
