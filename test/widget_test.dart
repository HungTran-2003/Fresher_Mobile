import 'package:crud_app/src/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

class MockFirebasePlatform extends Mock 
    with MockPlatformInterfaceMixin 
    implements FirebasePlatform {}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    
    final mockPlatform = MockFirebasePlatform();
    FirebasePlatform.instance = mockPlatform;
    
    final mockApp = FirebaseAppPlatform(
      defaultFirebaseAppName, 
      const FirebaseOptions(
        apiKey: 'test', 
        appId: 'test', 
        messagingSenderId: 'test', 
        projectId: 'test',
      ),
    );

    when(() => mockPlatform.initializeApp(
      name: any(named: 'name'),
      options: any(named: 'options'),
    )).thenAnswer((_) async => mockApp);

    when(() => mockPlatform.app(any())).thenReturn(mockApp);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('App basic initialization smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // The app should build successfully
    expect(find.byType(MyApp), findsOneWidget);

    // Let the splash delayed initialization complete so no timers are left pending
    await tester.pump(const Duration(seconds: 2));
  });
}
