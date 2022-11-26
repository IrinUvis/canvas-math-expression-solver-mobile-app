import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:canvas_equation_solver_mobile_app/main.dart' as app;

///to run: 'flutter test integration_test'

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test empty canvas message', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Draw equation sign by sign in the box above'),
        findsOneWidget);
  });
}
