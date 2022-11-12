import 'package:flutter/material.dart';
import 'package:canvas_equation_solver_mobile_app/theme/colors.dart';

class NumberContainer extends StatelessWidget {
  const NumberContainer({Key? key, required this.number}) : super(key: key);
  final int number;

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
        '$number',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
