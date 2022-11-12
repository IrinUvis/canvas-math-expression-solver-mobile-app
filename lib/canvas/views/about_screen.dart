import 'package:canvas_equation_solver_mobile_app/canvas/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:canvas_equation_solver_mobile_app/theme/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              'Canvas Equation Solver',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: orange200,
                  ),
            ),
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/icon.jpg'),
            ),
            const SizedBox(height: 30),
            Text(
              'Draw a simple equation\nand the app will solve it for you!',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
