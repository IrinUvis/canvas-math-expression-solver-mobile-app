import 'package:canvas_equation_solver_mobile_app/calculator/calculator.dart';
import 'package:canvas_equation_solver_mobile_app/math_symbol_creator/models/math_symbol.dart';
import 'package:canvas_equation_solver_mobile_app/math_symbol_creator/services/math_symbol_creator.dart';
import 'package:canvas_equation_solver_mobile_app/providers/user_input_provider.dart';
import 'package:canvas_equation_solver_mobile_app/tflite/classifiers/math_symbol_classifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_input_provider_test.mocks.dart';

class Listener extends Mock {
  void call(List<MathSymbol>? previous, List<MathSymbol> value);
}

@GenerateMocks([MathSymbolClassifier, Image, Calculator, MathSymbolCreator])
void main() {
  final MathSymbolCreator mathSymbolCreator = MockMathSymbolCreator();
  // final MathSymbolClassifier classifier = MockMathSymbolClassifier();
  // final Calculator calculator = MockCalculator();
  // final Image drawnSymbol = MockImage();
  group('test UserInputProvider', () {
    test('defaults to empty list and notify listeners when value changes', () async {
      // setup

      userInputProvider = StateNotifierProvider<UserInputNotifier, List<MathSymbol>>((ref) {
        return UserInputNotifier(mathSymbolCreator: mathSymbolCreator);
      });

      // An object that will allow us to read providers
      // Do not share this between tests.
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final listener = Listener();

      // Observe a provider and spy the changes.
      container.listen<List<MathSymbol>>(
        userInputProvider,
        listener,
        fireImmediately: true,
      );

      // the listener is called immediately with 0, the default value
      verify(listener(null, [])).called(1);
      verifyNoMoreInteractions(listener);

      const symbolFive = MathSymbol.five;

      // We add symbol
      container.read(userInputProvider.notifier).addSymbol(symbolFive);

      // The listener was called again, but with 1 this time
      verify(listener([], [symbolFive])).called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
