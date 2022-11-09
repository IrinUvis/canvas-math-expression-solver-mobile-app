import 'package:equatable/equatable.dart';

/// Wrapper class for all relevant prediction data.
class SymbolPredictionDetails extends Equatable {
  const SymbolPredictionDetails({
    required this.symbol,
    required this.predictionProbability,
  });

  final String symbol;
  final double predictionProbability;

  @override
  List<Object?> get props => [symbol, predictionProbability];
}