import 'package:crud_app/src/app.dart';
import 'package:crud_app/src/data/services/network/network_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    NetworkUtil.init();
    await Firebase.initializeApp();
  });

  testWidgets('App basic initialization smoke test', (WidgetTester tester) async {
    await SharedPreferences.getInstance();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // The app should build successfully
    expect(find.byType(MyApp), findsOneWidget);

    // Let the splash delayed initialization complete so no timers are left pending
    await tester.pump(const Duration(seconds: 2));
  });
}
