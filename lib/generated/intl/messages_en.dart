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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
    "closeButton": MessageLookupByLibrary.simpleMessage("Close"),
    "group": MessageLookupByLibrary.simpleMessage("Group"),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
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
    "okButton": MessageLookupByLibrary.simpleMessage("OK"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLengthError": MessageLookupByLibrary.simpleMessage(
      "Password must be between 6 and 50 characters.",
    ),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "taxIdOrIdError": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid 12-digit Citizen ID or 10-digit Tax Code (optional -XXX suffix).",
    ),
    "taxIdOrIdHint": MessageLookupByLibrary.simpleMessage(
      "Tax Code / Citizen ID",
    ),
    "taxIdOrIdLabel": MessageLookupByLibrary.simpleMessage(
      "Tax Code / Citizen ID",
    ),
    "usernameError": MessageLookupByLibrary.simpleMessage(
      "Username cannot be empty.",
    ),
    "usernameHint": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameLabel": MessageLookupByLibrary.simpleMessage("Username"),
  };
}
