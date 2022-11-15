import 'package:canvas_equation_solver_mobile_app/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// setup provider as a global variable
final equationResultProvider = NotifierProvider<EquationResultProvider, Either<Failure, double>>(EquationResultProvider.new);

class EquationResultProvider extends Notifier<Either<Failure, double>> {
  @override
  Either<Failure, double> build() {
    return const Left(NoInputFailure());
  }

  void setResult(double result) {
    state = Right(result);
  }

  void clearResult() {
    state = const Left(NoInputFailure());
  }
}
