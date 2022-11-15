import 'package:canvas_equation_solver_mobile_app/failures/failure.dart';
import 'package:canvas_equation_solver_mobile_app/providers/equation_result_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class Listener extends Mock {
  void call(Either<Failure, double>? previous, Either<Failure, double> value);
}

void main() {
  group('test UserInputProvider', () {
    test('defaults to NoInputFailure and notify listeners when value changes', () async {
      // setup

      equationResultProvider = StateNotifierProvider<EquationResultNotifier, Either<Failure, double>>((ref) {
        final equationResultNotifier = EquationResultNotifier(const Left(NoInputFailure()));
        return equationResultNotifier;
      });

      // An object that will allow us to read providers
      // Do not share this between tests.
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final listener = Listener();

      // Observe a provider and spy the changes.
      container.listen<Either<Failure, double>>(
        equationResultProvider,
        listener,
        fireImmediately: true,
      );

      // the listener is called immediately with 0, the default value
      verify(listener(null, const Left(NoInputFailure()))).called(1);
      verifyNoMoreInteractions(listener);

      // We set the result
      container.read(equationResultProvider.notifier).setResult(5.0);

      // The listener was called again, but with 1 this time
      verify(listener(const Left(NoInputFailure()), const Right(5.0))).called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
