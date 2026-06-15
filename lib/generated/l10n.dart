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

  /// `FinanceFlow`
  String get appName {
    return Intl.message('FinanceFlow', name: 'appName', desc: '', args: []);
  }

  /// `Total Balance`
  String get totalBalance {
    return Intl.message(
      'Total Balance',
      name: 'totalBalance',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message('Income', name: 'income', desc: '', args: []);
  }

  /// `Expense`
  String get expense {
    return Intl.message('Expense', name: 'expense', desc: '', args: []);
  }

  /// `Recent Transactions`
  String get recentTransactions {
    return Intl.message(
      'Recent Transactions',
      name: 'recentTransactions',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Add Transaction`
  String get addTransaction {
    return Intl.message(
      'Add Transaction',
      name: 'addTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Edit Transaction`
  String get editTransaction {
    return Intl.message(
      'Edit Transaction',
      name: 'editTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Note (Optional)`
  String get note {
    return Intl.message('Note (Optional)', name: 'note', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Budget`
  String get budget {
    return Intl.message('Budget', name: 'budget', desc: '', args: []);
  }

  /// `Budgets`
  String get budgets {
    return Intl.message('Budgets', name: 'budgets', desc: '', args: []);
  }

  /// `Analytics`
  String get analytics {
    return Intl.message('Analytics', name: 'analytics', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Tiếng Việt`
  String get vietnamese {
    return Intl.message('Tiếng Việt', name: 'vietnamese', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkLoc {
    return Intl.message('Dark Mode', name: 'darkLoc', desc: '', args: []);
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Biometric Authentication`
  String get biometrics {
    return Intl.message(
      'Biometric Authentication',
      name: 'biometrics',
      desc: '',
      args: [],
    );
  }

  /// `Budget limit exceeded!`
  String get limitWarning {
    return Intl.message(
      'Budget limit exceeded!',
      name: 'limitWarning',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remaining {
    return Intl.message('Remaining', name: 'remaining', desc: '', args: []);
  }

  /// `Enter Amount`
  String get enterAmount {
    return Intl.message(
      'Enter Amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Transaction added successfully`
  String get transactionAdded {
    return Intl.message(
      'Transaction added successfully',
      name: 'transactionAdded',
      desc: '',
      args: [],
    );
  }

  /// `Transaction deleted successfully`
  String get transactionDeleted {
    return Intl.message(
      'Transaction deleted successfully',
      name: 'transactionDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this transaction?`
  String get confirmDelete {
    return Intl.message(
      'Are you sure you want to delete this transaction?',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `No transactions yet. Start by adding one!`
  String get emptyTransactions {
    return Intl.message(
      'No transactions yet. Start by adding one!',
      name: 'emptyTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Spend Overview`
  String get monthlyReport {
    return Intl.message(
      'Monthly Spend Overview',
      name: 'monthlyReport',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Spending Trend`
  String get weeklySpend {
    return Intl.message(
      'Weekly Spending Trend',
      name: 'weeklySpend',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To Expense Manager`
  String get onboardingTitle1 {
    return Intl.message(
      'Welcome To Expense Manager',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Are You Ready To Take Control Of Your Finances?`
  String get onboardingTitle2 {
    return Intl.message(
      'Are You Ready To Take Control Of Your Finances?',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Username Or Email`
  String get usernameOrEmail {
    return Intl.message(
      'Username Or Email',
      name: 'usernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message('Log In', name: 'logIn', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Use Fingerprint To Access`
  String get useFingerprintToAccess {
    return Intl.message(
      'Use Fingerprint To Access',
      name: 'useFingerprintToAccess',
      desc: '',
      args: [],
    );
  }

  /// `or sign up with`
  String get orSignUpWith {
    return Intl.message(
      'or sign up with',
      name: 'orSignUpWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date Of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to `
  String get byContinuingAgree {
    return Intl.message(
      'By continuing, you agree to ',
      name: 'byContinuingAgree',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message('Terms of Use', name: 'termsOfUse', desc: '', args: []);
  }

  /// ` and `
  String get andWord {
    return Intl.message(' and ', name: 'andWord', desc: '', args: []);
  }

  /// `Privacy Policy.`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy.',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Sign In`
  String get biometricSignIn {
    return Intl.message(
      'Biometric Sign In',
      name: 'biometricSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Touch the sensor to log in`
  String get touchSensorToLogIn {
    return Intl.message(
      'Touch the sensor to log in',
      name: 'touchSensorToLogIn',
      desc: '',
      args: [],
    );
  }

  /// `Use your fingerprint scanner to verify your identity`
  String get useFingerprintScanner {
    return Intl.message(
      'Use your fingerprint scanner to verify your identity',
      name: 'useFingerprintScanner',
      desc: '',
      args: [],
    );
  }

  /// `Verifying fingerprint...`
  String get verifyingFingerprint {
    return Intl.message(
      'Verifying fingerprint...',
      name: 'verifyingFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Verification successful!`
  String get verificationSuccessful {
    return Intl.message(
      'Verification successful!',
      name: 'verificationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username or email`
  String get enterUsernameOrEmailError {
    return Intl.message(
      'Please enter your username or email',
      name: 'enterUsernameOrEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get enterPasswordError {
    return Intl.message(
      'Please enter your password',
      name: 'enterPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get enterFullNameError {
    return Intl.message(
      'Please enter your full name',
      name: 'enterFullNameError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get enterEmailError {
    return Intl.message(
      'Please enter your email',
      name: 'enterEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get enterValidEmailError {
    return Intl.message(
      'Please enter a valid email address',
      name: 'enterValidEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile number`
  String get enterMobileNumberError {
    return Intl.message(
      'Please enter your mobile number',
      name: 'enterMobileNumberError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your date of birth`
  String get enterDobError {
    return Intl.message(
      'Please enter your date of birth',
      name: 'enterDobError',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get enterConfirmPasswordError {
    return Intl.message(
      'Please confirm your password',
      name: 'enterConfirmPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatchError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordLengthError {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordLengthError',
      desc: '',
      args: [],
    );
  }

  /// `example@example.com`
  String get emailHint {
    return Intl.message(
      'example@example.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `••••••••`
  String get passwordHint {
    return Intl.message('••••••••', name: 'passwordHint', desc: '', args: []);
  }

  /// `+ 123 456 789`
  String get phoneHint {
    return Intl.message('+ 123 456 789', name: 'phoneHint', desc: '', args: []);
  }

  /// `DD / MM / YYYY`
  String get dateHint {
    return Intl.message('DD / MM / YYYY', name: 'dateHint', desc: '', args: []);
  }

  /// `example@example.com`
  String get fullNameHint {
    return Intl.message(
      'example@example.com',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password?`
  String get resetPassword {
    return Intl.message(
      'Reset Password?',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address to receive a verification pin to reset your password.`
  String get resetPasswordDescription {
    return Intl.message(
      'Please enter your email address to receive a verification pin to reset your password.',
      name: 'resetPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email Address`
  String get enterEmailAddress {
    return Intl.message(
      'Enter Email Address',
      name: 'enterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Next Step`
  String get nextStep {
    return Intl.message('Next Step', name: 'nextStep', desc: '', args: []);
  }

  /// `Security Pin`
  String get securityPin {
    return Intl.message(
      'Security Pin',
      name: 'securityPin',
      desc: '',
      args: [],
    );
  }

  /// `Enter Security Pin`
  String get enterSecurityPin {
    return Intl.message(
      'Enter Security Pin',
      name: 'enterSecurityPin',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Send Again`
  String get sendAgain {
    return Intl.message('Send Again', name: 'sendAgain', desc: '', args: []);
  }

  /// `New Password`
  String get newPasswordTitle {
    return Intl.message(
      'New Password',
      name: 'newPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully! Please log in with your new password.`
  String get passwordChangedSuccess {
    return Intl.message(
      'Password changed successfully! Please log in with your new password.',
      name: 'passwordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `A new verification PIN has been sent to your email.`
  String get resendPinSuccess {
    return Intl.message(
      'A new verification PIN has been sent to your email.',
      name: 'resendPinSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Invalid PIN code. Please try again.`
  String get invalidPinError {
    return Intl.message(
      'Invalid PIN code. Please try again.',
      name: 'invalidPinError',
      desc: '',
      args: [],
    );
  }

  /// `Hi, Welcome Back`
  String get hiWelcomeBack {
    return Intl.message(
      'Hi, Welcome Back',
      name: 'hiWelcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get goodMorning {
    return Intl.message(
      'Good Morning',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good Noon`
  String get goodNoon {
    return Intl.message('Good Noon', name: 'goodNoon', desc: '', args: []);
  }

  /// `Good Afternoon`
  String get goodAfternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get goodEvening {
    return Intl.message(
      'Good Evening',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `Good Night`
  String get goodNight {
    return Intl.message('Good Night', name: 'goodNight', desc: '', args: []);
  }

  /// `Total Expense`
  String get totalExpense {
    return Intl.message(
      'Total Expense',
      name: 'totalExpense',
      desc: '',
      args: [],
    );
  }

  /// `30% Of Your Expenses, Looks Good.`
  String get expensesLooksGood {
    return Intl.message(
      '30% Of Your Expenses, Looks Good.',
      name: 'expensesLooksGood',
      desc: '',
      args: [],
    );
  }

  /// `Savings On Goals`
  String get savingsOnGoals {
    return Intl.message(
      'Savings On Goals',
      name: 'savingsOnGoals',
      desc: '',
      args: [],
    );
  }

  /// `Revenue Last Week`
  String get revenueLastWeek {
    return Intl.message(
      'Revenue Last Week',
      name: 'revenueLastWeek',
      desc: '',
      args: [],
    );
  }

  /// `Food Last Week`
  String get foodLastWeek {
    return Intl.message(
      'Food Last Week',
      name: 'foodLastWeek',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message('Daily', name: 'daily', desc: '', args: []);
  }

  /// `Weekly`
  String get weekly {
    return Intl.message('Weekly', name: 'weekly', desc: '', args: []);
  }

  /// `Monthly`
  String get monthly {
    return Intl.message('Monthly', name: 'monthly', desc: '', args: []);
  }

  /// `Salary`
  String get salary {
    return Intl.message('Salary', name: 'salary', desc: '', args: []);
  }

  /// `Groceries`
  String get groceries {
    return Intl.message('Groceries', name: 'groceries', desc: '', args: []);
  }

  /// `Rent`
  String get rent {
    return Intl.message('Rent', name: 'rent', desc: '', args: []);
  }

  /// `Pantry`
  String get pantry {
    return Intl.message('Pantry', name: 'pantry', desc: '', args: []);
  }

  /// `Quickly Analysis`
  String get quicklyAnalysis {
    return Intl.message(
      'Quickly Analysis',
      name: 'quicklyAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `April Expenses`
  String get aprilExpenses {
    return Intl.message(
      'April Expenses',
      name: 'aprilExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
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
