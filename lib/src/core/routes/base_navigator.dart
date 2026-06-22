import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Lớp cơ sở (Base) quản lý toàn bộ luồng điều hướng của từng màn hình.
/// Mỗi màn hình sẽ có một lớp Navigator tương ứng kế thừa từ [BaseNavigator].
abstract class BaseNavigator {
  final BuildContext? _context;
  BuildContext get context => _context ?? Get.context!;

  BaseNavigator([this._context]);

  /// Navigates to the specified route using GetX.
  void pop<T extends Object?>([T? result]) {
    Get.back<T>(result: result);
  }

  /// Pops if possible, otherwise navigates to home.
  void popOrGoHome() {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    } else {
      Get.offAllNamed(AppRouters.home);
    }
  }

  /// Pops the current route until the specified route is reached.
  void popUntilNamed(String name) {
    Get.until((route) => route.settings.name == name);
  }

  Future<dynamic>? goNamed(String name, {Object? extra}) {
    return Get.offAllNamed(name, arguments: extra);
  }

  /// Pushes a new route onto the navigator stack.
  Future<dynamic>? pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    Object? arguments,
  }) {
    return Get.toNamed(
      name,
      arguments: arguments ?? extra,
      parameters: pathParameters.isNotEmpty ? pathParameters : null,
    );
  }

  /// Replaces the current route with a new one.
  Future<dynamic>? pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return Get.offNamed(
      name,
      arguments: extra,
      parameters: pathParameters.isNotEmpty ? pathParameters : null,
    );
  }

  /// Pushes a new page onto the navigator stack.
  Future<dynamic>? pushPage(Widget page) {
    return Get.to(() => page);
  }

  Future<void> showErrorDialog({
    String? title,
    required String message,
    VoidCallback? closeAction,
  }) async {
    if (message == '') return;
    await AppDialog.show(
      dialogType: DialogType.errorAlert,
      context: context,
      titleText: title ?? "error",
      messageText: message,
      confirmButtonText: "close",
      declineButtonText: 'cancel',
    );
    closeAction?.call();
  }

  Future<void> showSuccessSnackBar({
    String? title,
    required String message,
  }) async {
    if (message == '') return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
