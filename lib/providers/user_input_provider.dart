import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// setup provider as a global variable
final userInputProvider = NotifierProvider<UserInputProvider, List<MathSymbol>>(UserInputProvider.new);

class UserInputProvider extends Notifier<List<MathSymbol>> {
  @override
  List<MathSymbol> build() {
    return [];
  }

  void addSymbol(MathSymbol symbol) {
    state.add(symbol);
  }

  void deleteSymbol(int index) {
    state.removeAt(index);
  }

  void deleteAll() {
    state = [];
  }

  void swapTwoSymbols(int firstIndex, int secondIndex) {
    MathSymbol firstSymbol = state[firstIndex];
    MathSymbol secondSymbol = state[secondIndex];
    state[firstIndex] = secondSymbol;
    state[secondIndex] = firstSymbol;
  }
}
