import 'package:canvas_equation_solver_mobile_app/math_operation_creator/models/math_symbol.dart';
import 'package:equatable/equatable.dart';

class MathOperation extends Equatable {
  const MathOperation({
    required this.operationElements,
    required this.result,
    this.errorMessage,
  });

  final List<MathSymbol> operationElements;
  final double result;
  final String? errorMessage;

  @override
  List<Object?> get props => [operationElements, result, errorMessage];
}
