import 'package:flutter/material.dart';
import 'package:canvas_equation_solver_mobile_app/theme/colors.dart';

class SymbolContainer extends StatelessWidget {
  const SymbolContainer({Key? key, required this.symbol, this.onDelete}) : super(key: key);
  final String symbol;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: orange500,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          width: 60,
          height: 60,
          child: Center(
            child: Text(
              symbol,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        InkWell(
            onTap: onDelete,
            child: const Icon(
              Icons.cancel_outlined,
              color: Colors.white,
              size: 40,
            ))
      ],
    );
  }
}
