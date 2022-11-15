import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class NoInputFailure extends Failure {
  const NoInputFailure() : super("Draw equation sign by sign in the box above");
}

class CalculatorFailure extends Failure {
  const CalculatorFailure(String message) : super(message);
}
