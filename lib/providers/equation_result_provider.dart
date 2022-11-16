import 'package:canvas_equation_solver_mobile_app/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// setup provider as a global variable
late final StateNotifierProvider<EquationResultNotifier, Either<Failure, double>> equationResultProvider;

class EquationResultNotifier extends StateNotifier<Either<Failure, double>> {
  EquationResultNotifier(Either<Failure, double> result) : super(result);

  void setResult(double result) {
    state = Right(result);
  }

  void clearResult() {
    state = const Left(NoInputFailure());
  }
}
