// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "Stock: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountLockedError": MessageLookupByLibrary.simpleMessage(
      "Your account has been temporarily locked for 5 minutes due to multiple failed login attempts.",
    ),
    "active": MessageLookupByLibrary.simpleMessage("Active"),
    "addNewProduct": MessageLookupByLibrary.simpleMessage("Add New Product"),
    "addProduct": MessageLookupByLibrary.simpleMessage("Add product"),
    "adjustSearchOrFilters": MessageLookupByLibrary.simpleMessage(
      "Try adjusting your search query or filters.",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage("All Categories"),
    "allStatuses": MessageLookupByLibrary.simpleMessage("All Statuses"),
    "biometricAuthReason": MessageLookupByLibrary.simpleMessage(
      "Authenticate to enable biometric login",
    ),
    "biometricLoginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Use Face ID / Fingerprint to log in next time",
    ),
    "biometricLoginTitle": MessageLookupByLibrary.simpleMessage(
      "Biometric Login",
    ),
    "biometricSetupFailed": MessageLookupByLibrary.simpleMessage(
      "Biometric authentication is not supported or not set up on this device.",
    ),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelButtonLabel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "closeButton": MessageLookupByLibrary.simpleMessage("Close"),
    "codeRequired": MessageLookupByLibrary.simpleMessage(
      "Product code is required",
    ),
    "createdAtLabel": MessageLookupByLibrary.simpleMessage("Created at"),
    "defaultSort": MessageLookupByLibrary.simpleMessage("Default Sort"),
    "deleteButton": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteProductConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this product?",
    ),
    "deleteProductConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Product",
    ),
    "descriptionHint": MessageLookupByLibrary.simpleMessage(
      "Enter product description",
    ),
    "descriptionLabel": MessageLookupByLibrary.simpleMessage("Description"),
    "failedToAddProduct": MessageLookupByLibrary.simpleMessage(
      "Failed to add product",
    ),
    "failedToLoadProducts": MessageLookupByLibrary.simpleMessage(
      "Failed to load products",
    ),
    "failedToUploadImage": MessageLookupByLibrary.simpleMessage(
      "Failed to upload image",
    ),
    "group": MessageLookupByLibrary.simpleMessage("Group"),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "inactive": MessageLookupByLibrary.simpleMessage("Inactive"),
    "logIn": MessageLookupByLibrary.simpleMessage("Login"),
    "loginErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Invalid login credentials",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "logoutConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Logout Confirmation",
    ),
    "lookup": MessageLookupByLibrary.simpleMessage("Search"),
    "nameAsc": MessageLookupByLibrary.simpleMessage("Name A→Z"),
    "nameDesc": MessageLookupByLibrary.simpleMessage("Name Z→A"),
    "nameRequired": MessageLookupByLibrary.simpleMessage(
      "Product name is required",
    ),
    "noProductsFound": MessageLookupByLibrary.simpleMessage(
      "No products found",
    ),
    "notificationTitle": MessageLookupByLibrary.simpleMessage("Notification"),
    "okButton": MessageLookupByLibrary.simpleMessage("OK"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLengthError": MessageLookupByLibrary.simpleMessage(
      "Password must be between 6 and 50 characters.",
    ),
    "pickImage": MessageLookupByLibrary.simpleMessage("Pick Image"),
    "priceAsc": MessageLookupByLibrary.simpleMessage("Price ↑"),
    "priceDesc": MessageLookupByLibrary.simpleMessage("Price ↓"),
    "priceHint": MessageLookupByLibrary.simpleMessage("Enter price"),
    "priceLabel": MessageLookupByLibrary.simpleMessage("Price"),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Price must be greater than 0",
    ),
    "priceRequired": MessageLookupByLibrary.simpleMessage("Price is required"),
    "productAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Product added successfully",
    ),
    "productCodeHint": MessageLookupByLibrary.simpleMessage(
      "Enter unique code",
    ),
    "productCodeLabel": MessageLookupByLibrary.simpleMessage("Product Code"),
    "productDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Product deleted successfully",
    ),
    "productManagement": MessageLookupByLibrary.simpleMessage(
      "Product Management",
    ),
    "productNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter product name",
    ),
    "productNameLabel": MessageLookupByLibrary.simpleMessage("Product Name"),
    "productUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Product updated successfully",
    ),
    "removeImage": MessageLookupByLibrary.simpleMessage("Remove Image"),
    "saveButton": MessageLookupByLibrary.simpleMessage("Save"),
    "searchProductHint": MessageLookupByLibrary.simpleMessage(
      "Search products by name...",
    ),
    "sku": MessageLookupByLibrary.simpleMessage("SKU"),
    "sortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stockAsc": MessageLookupByLibrary.simpleMessage("Stock ↑"),
    "stockCount": m0,
    "stockDesc": MessageLookupByLibrary.simpleMessage("Stock ↓"),
    "stockHint": MessageLookupByLibrary.simpleMessage("Enter stock quantity"),
    "stockLabel": MessageLookupByLibrary.simpleMessage("Stock"),
    "stockNonNegative": MessageLookupByLibrary.simpleMessage(
      "Stock cannot be negative",
    ),
    "stockOnlyInteger": MessageLookupByLibrary.simpleMessage(
      "Stock must be an integer",
    ),
    "stockRequired": MessageLookupByLibrary.simpleMessage("Stock is required"),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "tagsHint": MessageLookupByLibrary.simpleMessage(
      "Enter tags (comma separated)",
    ),
    "tagsLabel": MessageLookupByLibrary.simpleMessage("Tags"),
    "taxIdOrIdError": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid 12-digit Citizen ID or 10-digit Tax Code (optional -XXX suffix).",
    ),
    "taxIdOrIdHint": MessageLookupByLibrary.simpleMessage(
      "Tax Code / Citizen ID",
    ),
    "taxIdOrIdLabel": MessageLookupByLibrary.simpleMessage(
      "Tax Code / Citizen ID",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "updatedAtDesc": MessageLookupByLibrary.simpleMessage("Newest Updated"),
    "updatedAtLabel": MessageLookupByLibrary.simpleMessage("Updated at"),
    "usernameError": MessageLookupByLibrary.simpleMessage(
      "Username cannot be empty.",
    ),
    "usernameHint": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameLabel": MessageLookupByLibrary.simpleMessage("Username"),
  };
}
