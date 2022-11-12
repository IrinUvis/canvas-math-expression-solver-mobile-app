import 'package:flutter/material.dart';
import 'package:canvas_equation_solver_mobile_app/theme/colors.dart';

class SymbolContainer extends StatelessWidget {
  const SymbolContainer({Key? key, required this.symbol}) : super(key: key);
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: orange500,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        symbol,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
