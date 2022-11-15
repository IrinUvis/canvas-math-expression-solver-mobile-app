import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInputProvider extends StateNotifier<List<MathSymbol>> {
  UserInputProvider() : super([]);

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
