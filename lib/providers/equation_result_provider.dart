import 'package:canvas_equation_solver_mobile_app/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EquationResultProvider extends StateNotifier<Either<Failure, double>> {
  EquationResultProvider() : super(const Left(NoInputFailure()));

  void setResult(double result) {
    state = Right(result);
  }

  void clearResult() {
    state = const Left(NoInputFailure());
  }
}
