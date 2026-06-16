// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Login`
  String get logIn {
    return Intl.message('Login', name: 'logIn', desc: '', args: []);
  }

  /// `Tax Code / Citizen ID`
  String get taxIdOrIdLabel {
    return Intl.message(
      'Tax Code / Citizen ID',
      name: 'taxIdOrIdLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tax Code / Citizen ID`
  String get taxIdOrIdHint {
    return Intl.message(
      'Tax Code / Citizen ID',
      name: 'taxIdOrIdHint',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get usernameLabel {
    return Intl.message('Username', name: 'usernameLabel', desc: '', args: []);
  }

  /// `Username`
  String get usernameHint {
    return Intl.message('Username', name: 'usernameHint', desc: '', args: []);
  }

  /// `Password`
  String get passwordHint {
    return Intl.message('Password', name: 'passwordHint', desc: '', args: []);
  }

  /// `Please enter a valid 12-digit Citizen ID or 10-digit Tax Code (optional -XXX suffix).`
  String get taxIdOrIdError {
    return Intl.message(
      'Please enter a valid 12-digit Citizen ID or 10-digit Tax Code (optional -XXX suffix).',
      name: 'taxIdOrIdError',
      desc: '',
      args: [],
    );
  }

  /// `Username cannot be empty.`
  String get usernameError {
    return Intl.message(
      'Username cannot be empty.',
      name: 'usernameError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be between 6 and 50 characters.`
  String get passwordLengthError {
    return Intl.message(
      'Password must be between 6 and 50 characters.',
      name: 'passwordLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid login credentials`
  String get loginErrorTitle {
    return Intl.message(
      'Invalid login credentials',
      name: 'loginErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeButton {
    return Intl.message('Close', name: 'closeButton', desc: '', args: []);
  }

  /// `Logout Confirmation`
  String get logoutConfirmTitle {
    return Intl.message(
      'Logout Confirmation',
      name: 'logoutConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirmMessage {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okButton {
    return Intl.message('OK', name: 'okButton', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message('Cancel', name: 'cancelButton', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Group`
  String get group {
    return Intl.message('Group', name: 'group', desc: '', args: []);
  }

  /// `Search`
  String get lookup {
    return Intl.message('Search', name: 'lookup', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
