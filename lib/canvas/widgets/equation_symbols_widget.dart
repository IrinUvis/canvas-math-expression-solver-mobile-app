import 'package:canvas_equation_solver_mobile_app/canvas/widgets/number_container.dart';
import 'package:canvas_equation_solver_mobile_app/providers/user_input_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EquationSymbolsWidget extends ConsumerWidget {
  const EquationSymbolsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInput = ref.watch(userInputProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...userInput.asMap().entries.map((e) {
            return SymbolContainer(
                symbol: e.value.toString(), onDelete: (() => ref.read(userInputProvider.notifier).deleteSymbol(e.key)));
          })
        ],
      ),
    );
  }
}
