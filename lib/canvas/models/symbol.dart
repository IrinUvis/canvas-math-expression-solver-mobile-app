/// Enum class containing all symbols.
enum Symbol {
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
  unknown;

  @override
  String toString() {
    switch(this) {
      case Symbol.zero:
        return '0';
      case Symbol.one:
        return '1';
      case Symbol.two:
        return '2';
      case Symbol.three:
        return '3';
      case Symbol.four:
        return '4';
      case Symbol.five:
        return '5';
      case Symbol.six:
        return '6';
      case Symbol.seven:
        return '7';
      case Symbol.eight:
        return '8';
      case Symbol.nine:
        return '9';
      case Symbol.plus:
        return '+';
      case Symbol.minus:
        return '-';
      case Symbol.multiply:
        return '*';
      case Symbol.division:
        return '/';
      case Symbol.unknown:
        return 'unknown';
    }
  }
}