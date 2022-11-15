import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/calculator/exception/calculator_exception.dart';
import 'package:canvas_equation_solver_mobile_app/canvas_equation_solver.dart';
import 'package:canvas_equation_solver_mobile_app/failures/failure.dart';
import 'package:canvas_equation_solver_mobile_app/math_symbol_creator/models/math_symbol.dart';
import 'package:canvas_equation_solver_mobile_app/math_symbol_creator/services/math_symbol_creator.dart';
import 'package:canvas_equation_solver_mobile_app/providers/equation_result_provider.dart';
import 'package:canvas_equation_solver_mobile_app/providers/user_input_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final calculator = Calculator();

  final mathSymbolCreator = await MathSymbolCreator.create(classifier: null, calculator: calculator);

  userInputProvider = StateNotifierProvider<UserInputNotifier, List<MathSymbol>>((ref) {
    return UserInputNotifier(mathSymbolCreator: mathSymbolCreator);
  });
c
  // finally, run the app
  runApp(const ProviderScope(child: CanvasEquationSolver()));
}
