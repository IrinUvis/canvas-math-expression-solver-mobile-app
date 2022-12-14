import 'package:canvas_equation_solver_mobile_app/canvas/views/about_screen.dart';
import 'package:canvas_equation_solver_mobile_app/canvas/views/canvas_screen.dart';
import 'package:canvas_equation_solver_mobile_app/theme/colors.dart';
import 'package:flutter/material.dart';

class CanvasEquationSolver extends StatelessWidget {
  const CanvasEquationSolver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canvas Equation Solver',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          accentColor: accentColor,
          backgroundColor: backgroundColor,
          cardColor: cardColor,
          brightness: Brightness.dark,
        ),
        textTheme: Typography.whiteMountainView,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CanvasScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
