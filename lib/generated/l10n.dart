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
    return _current ?? S();
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

  /// `Your account has been temporarily locked for 5 minutes due to multiple failed login attempts.`
  String get accountLockedError {
    return Intl.message(
      'Your account has been temporarily locked for 5 minutes due to multiple failed login attempts.',
      name: 'accountLockedError',
      desc: '',
      args: [],
    );
  }

  /// `Biometric authentication is not supported or not set up on this device.`
  String get biometricSetupFailed {
    return Intl.message(
      'Biometric authentication is not supported or not set up on this device.',
      name: 'biometricSetupFailed',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Login`
  String get biometricLoginTitle {
    return Intl.message(
      'Biometric Login',
      name: 'biometricLoginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use Face ID / Fingerprint to log in next time`
  String get biometricLoginSubtitle {
    return Intl.message(
      'Use Face ID / Fingerprint to log in next time',
      name: 'biometricLoginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Product Management`
  String get productManagement {
    return Intl.message(
      'Product Management',
      name: 'productManagement',
      desc: '',
      args: [],
    );
  }

  /// `Search products by name...`
  String get searchProductHint {
    return Intl.message(
      'Search products by name...',
      name: 'searchProductHint',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `All Statuses`
  String get allStatuses {
    return Intl.message(
      'All Statuses',
      name: 'allStatuses',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Inactive`
  String get inactive {
    return Intl.message('Inactive', name: 'inactive', desc: '', args: []);
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message('Sort by', name: 'sortBy', desc: '', args: []);
  }

  /// `Default Sort`
  String get defaultSort {
    return Intl.message(
      'Default Sort',
      name: 'defaultSort',
      desc: '',
      args: [],
    );
  }

  /// `Name A→Z`
  String get nameAsc {
    return Intl.message('Name A→Z', name: 'nameAsc', desc: '', args: []);
  }

  /// `Name Z→A`
  String get nameDesc {
    return Intl.message('Name Z→A', name: 'nameDesc', desc: '', args: []);
  }

  /// `Price ↑`
  String get priceAsc {
    return Intl.message('Price ↑', name: 'priceAsc', desc: '', args: []);
  }

  /// `Price ↓`
  String get priceDesc {
    return Intl.message('Price ↓', name: 'priceDesc', desc: '', args: []);
  }

  /// `Stock ↑`
  String get stockAsc {
    return Intl.message('Stock ↑', name: 'stockAsc', desc: '', args: []);
  }

  /// `Stock ↓`
  String get stockDesc {
    return Intl.message('Stock ↓', name: 'stockDesc', desc: '', args: []);
  }

  /// `Newest Updated`
  String get updatedAtDesc {
    return Intl.message(
      'Newest Updated',
      name: 'updatedAtDesc',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load products`
  String get failedToLoadProducts {
    return Intl.message(
      'Failed to load products',
      name: 'failedToLoadProducts',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `No products found`
  String get noProductsFound {
    return Intl.message(
      'No products found',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Try adjusting your search query or filters.`
  String get adjustSearchOrFilters {
    return Intl.message(
      'Try adjusting your search query or filters.',
      name: 'adjustSearchOrFilters',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get addProduct {
    return Intl.message('Add product', name: 'addProduct', desc: '', args: []);
  }

  /// `SKU`
  String get sku {
    return Intl.message('SKU', name: 'sku', desc: '', args: []);
  }

  /// `Stock: {count}`
  String stockCount(Object count) {
    return Intl.message(
      'Stock: $count',
      name: 'stockCount',
      desc: '',
      args: [count],
    );
  }

  /// `Add New Product`
  String get addNewProduct {
    return Intl.message(
      'Add New Product',
      name: 'addNewProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productNameLabel {
    return Intl.message(
      'Product Name',
      name: 'productNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter product name`
  String get productNameHint {
    return Intl.message(
      'Enter product name',
      name: 'productNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Product Code`
  String get productCodeLabel {
    return Intl.message(
      'Product Code',
      name: 'productCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter unique code`
  String get productCodeHint {
    return Intl.message(
      'Enter unique code',
      name: 'productCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get priceLabel {
    return Intl.message('Price', name: 'priceLabel', desc: '', args: []);
  }

  /// `Enter price`
  String get priceHint {
    return Intl.message('Enter price', name: 'priceHint', desc: '', args: []);
  }

  /// `Stock`
  String get stockLabel {
    return Intl.message('Stock', name: 'stockLabel', desc: '', args: []);
  }

  /// `Enter stock quantity`
  String get stockHint {
    return Intl.message(
      'Enter stock quantity',
      name: 'stockHint',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tagsLabel {
    return Intl.message('Tags', name: 'tagsLabel', desc: '', args: []);
  }

  /// `Enter tags (comma separated)`
  String get tagsHint {
    return Intl.message(
      'Enter tags (comma separated)',
      name: 'tagsHint',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionLabel {
    return Intl.message(
      'Description',
      name: 'descriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter product description`
  String get descriptionHint {
    return Intl.message(
      'Enter product description',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message('Save', name: 'saveButton', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelButtonLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get pickImage {
    return Intl.message('Pick Image', name: 'pickImage', desc: '', args: []);
  }

  /// `Remove Image`
  String get removeImage {
    return Intl.message(
      'Remove Image',
      name: 'removeImage',
      desc: '',
      args: [],
    );
  }

  /// `Product name is required`
  String get nameRequired {
    return Intl.message(
      'Product name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Product code is required`
  String get codeRequired {
    return Intl.message(
      'Product code is required',
      name: 'codeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Price is required`
  String get priceRequired {
    return Intl.message(
      'Price is required',
      name: 'priceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Price must be greater than 0`
  String get pricePositive {
    return Intl.message(
      'Price must be greater than 0',
      name: 'pricePositive',
      desc: '',
      args: [],
    );
  }

  /// `Stock is required`
  String get stockRequired {
    return Intl.message(
      'Stock is required',
      name: 'stockRequired',
      desc: '',
      args: [],
    );
  }

  /// `Stock cannot be negative`
  String get stockNonNegative {
    return Intl.message(
      'Stock cannot be negative',
      name: 'stockNonNegative',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully`
  String get productAddedSuccess {
    return Intl.message(
      'Product added successfully',
      name: 'productAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add product`
  String get failedToAddProduct {
    return Intl.message(
      'Failed to add product',
      name: 'failedToAddProduct',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get deleteProductConfirmTitle {
    return Intl.message(
      'Delete Product',
      name: 'deleteProductConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product?`
  String get deleteProductConfirmMessage {
    return Intl.message(
      'Are you sure you want to delete this product?',
      name: 'deleteProductConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteButton {
    return Intl.message('Delete', name: 'deleteButton', desc: '', args: []);
  }

  /// `Product deleted successfully`
  String get productDeletedSuccess {
    return Intl.message(
      'Product deleted successfully',
      name: 'productDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload image`
  String get failedToUploadImage {
    return Intl.message(
      'Failed to upload image',
      name: 'failedToUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate to enable biometric login`
  String get biometricAuthReason {
    return Intl.message(
      'Authenticate to enable biometric login',
      name: 'biometricAuthReason',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notificationTitle {
    return Intl.message(
      'Notification',
      name: 'notificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Product updated successfully`
  String get productUpdateSuccess {
    return Intl.message(
      'Product updated successfully',
      name: 'productUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Stock must be an integer`
  String get stockOnlyInteger {
    return Intl.message(
      'Stock must be an integer',
      name: 'stockOnlyInteger',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get createdAtLabel {
    return Intl.message(
      'Created at',
      name: 'createdAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Updated at`
  String get updatedAtLabel {
    return Intl.message(
      'Updated at',
      name: 'updatedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retryButton {
    return Intl.message('Retry', name: 'retryButton', desc: '', args: []);
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
