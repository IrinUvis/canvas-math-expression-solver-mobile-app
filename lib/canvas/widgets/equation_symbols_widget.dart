import 'package:canvas_equation_solver_mobile_app/canvas/widgets/number_container.dart';
import 'package:canvas_equation_solver_mobile_app/providers/user_input_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

class EquationSymbolsWidget extends ConsumerWidget {
  const EquationSymbolsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInput = ref.watch(userInputProvider);

    void onReorder(int oldIndex, int newIndex) {
      ref.read(userInputProvider.notifier).swapTwoSymbols(oldIndex, newIndex);
    }

    return Container(
      child: ReorderableGridView.extent(
        // crossAxisCount: 3,
        maxCrossAxisExtent: 100,
        onReorder: onReorder,
        childAspectRatio: 1,
        children: userInput.asMap().entries.map((e) {
          return SymbolContainer(
              key: ValueKey(e),
              symbol: e.value.toString(),
              onDelete: (() => ref.read(userInputProvider.notifier).deleteSymbol(e.key)));
        }).toList(),
      ),
    );

    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: [
    //       ...userInput.asMap().entries.map((e) {
    //         return SymbolContainer(
    //             symbol: e.value.toString(), onDelete: (() => ref.read(userInputProvider.notifier).deleteSymbol(e.key)));
    //       })
    //     ],
    //   ),
    // );
  }
}
