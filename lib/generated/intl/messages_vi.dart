// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountLockedError": MessageLookupByLibrary.simpleMessage(
      "Tài khoản của bạn đã bị tạm khoá trong 5 phút do nhập sai nhiều lần.",
    ),
    "biometricLoginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sử dụng vân tay / Face ID cho lần đăng nhập sau",
    ),
    "biometricLoginTitle": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập sinh trắc học",
    ),
    "biometricSetupFailed": MessageLookupByLibrary.simpleMessage(
      "Thiết bị không hỗ trợ hoặc chưa cài đặt sinh trắc học.",
    ),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Hủy"),
    "closeButton": MessageLookupByLibrary.simpleMessage("Đóng"),
    "group": MessageLookupByLibrary.simpleMessage("Group"),
    "help": MessageLookupByLibrary.simpleMessage("Trợ giúp"),
    "logIn": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
    "loginErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Thông tin đăng nhập không hợp lệ",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "logoutConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc chắn muốn đăng xuất?",
    ),
    "logoutConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Xác nhận đăng xuất",
    ),
    "lookup": MessageLookupByLibrary.simpleMessage("Tra cứu"),
    "okButton": MessageLookupByLibrary.simpleMessage("OK"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
    "passwordLengthError": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu phải từ 6–50 ký tự",
    ),
    "support": MessageLookupByLibrary.simpleMessage("Trợ giúp"),
    "taxIdOrIdError": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập CCCD 12 số hoặc MST hợp lệ (10 số, có thể kèm ‘-XXX’).",
    ),
    "taxIdOrIdHint": MessageLookupByLibrary.simpleMessage("Mã số thuế"),
    "taxIdOrIdLabel": MessageLookupByLibrary.simpleMessage("Mã số thuế"),
    "usernameError": MessageLookupByLibrary.simpleMessage(
      "Tài khoản không được để trống.",
    ),
    "usernameHint": MessageLookupByLibrary.simpleMessage("Tài khoản"),
    "usernameLabel": MessageLookupByLibrary.simpleMessage("Tài khoản"),
  };
}
