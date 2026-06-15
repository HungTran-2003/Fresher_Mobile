import 'package:finance/src/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'https://mock.supabase.co',
      anonKey: 'sb_publishable_mock',
    );
  });

  testWidgets('App basic initialization smoke test', (WidgetTester tester) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(sharedPreferences: sharedPreferences));

    // The app should build successfully
    expect(find.byType(MyApp), findsOneWidget);

    // Let the splash delayed initialization complete so no timers are left pending
    await tester.pump(const Duration(seconds: 2));
  });
}
