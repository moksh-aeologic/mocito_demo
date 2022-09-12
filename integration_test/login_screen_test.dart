import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocito_demo/mock_wrapper.dart';
// import 'package:mocito_demo/main.dart';
import 'package:mocito_demo/screens/login_screen.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  group("Login screen test", () {
    testWidgets('Login screen test (Integration test)',
        (WidgetTester tester) async {
      await tester.pumpWidget(Mockwrapper(child: LoginScreen()));
      Finder emailFinder = find.byKey(const ValueKey("email_key"));
      Finder passwordFinder = find.byKey(const ValueKey("password_key"));
      Finder loginButton = find.byType(ElevatedButton);
      await tester.enterText(emailFinder, "Moksh@aeologic.com");
      await tester.enterText(passwordFinder, "1234567890");
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      Finder loginSuccessMessage = find.byType(Text);

      // await tester.tap(find.text('Save'));
      expect(loginSuccessMessage, findsOneWidget);
    });
  });
}
