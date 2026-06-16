import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/utils/app_validators.dart';

void main() {
  testWidgets('AppValidators Validation Logic and Localized Errors Test', (WidgetTester tester) async {
    late BuildContext testContext;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('vi'),
        home: Builder(
          builder: (context) {
            testContext = context;
            return const SizedBox();
          },
        ),
      ),
    );

    // Wait for the localizations to load
    await tester.pumpAndSettle();

    // 1. Test taxIdOrId validator
    // Valid CCCD (12 digits)
    expect(AppValidators.validateTaxIdOrId(testContext, '020076664492'), isNull);
    // Valid MST with suffix (10 digits - 3 digits)
    expect(AppValidators.validateTaxIdOrId(testContext, '0105987432-098'), isNull);
    // Valid MST without suffix (10 digits)
    expect(AppValidators.validateTaxIdOrId(testContext, '0105987432'), isNull);
    
    // Invalid inputs
    final taxIdErrorMsg = S.of(testContext).taxIdOrIdError;
    expect(AppValidators.validateTaxIdOrId(testContext, '123'), equals(taxIdErrorMsg));
    expect(AppValidators.validateTaxIdOrId(testContext, '0105987432-09'), equals(taxIdErrorMsg));
    expect(AppValidators.validateTaxIdOrId(testContext, 'abcdefghijkl'), equals(taxIdErrorMsg));
    expect(AppValidators.validateTaxIdOrId(testContext, ''), equals(taxIdErrorMsg));
    expect(AppValidators.validateTaxIdOrId(testContext, null), equals(taxIdErrorMsg));

    // 2. Test username validator
    expect(AppValidators.validateUsername(testContext, 'demo'), isNull);
    final usernameErrorMsg = S.of(testContext).usernameError;
    expect(AppValidators.validateUsername(testContext, ''), equals(usernameErrorMsg));
    expect(AppValidators.validateUsername(testContext, '   '), equals(usernameErrorMsg));
    expect(AppValidators.validateUsername(testContext, null), equals(usernameErrorMsg));

    // 3. Test login password validator
    expect(AppValidators.validateLoginPassword(testContext, '123456'), isNull);
    expect(AppValidators.validateLoginPassword(testContext, 'a' * 50), isNull);
    
    final passwordErrorMsg = S.of(testContext).passwordLengthError;
    expect(AppValidators.validateLoginPassword(testContext, '12345'), equals(passwordErrorMsg));
    expect(AppValidators.validateLoginPassword(testContext, 'a' * 51), equals(passwordErrorMsg));
    expect(AppValidators.validateLoginPassword(testContext, ''), equals(passwordErrorMsg));
    expect(AppValidators.validateLoginPassword(testContext, null), equals(passwordErrorMsg));
  });
}
