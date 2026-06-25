import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Lớp cơ sở (Base) quản lý toàn bộ luồng điều hướng của từng màn hình.
/// Mỗi màn hình sẽ có một lớp Navigator tương ứng kế thừa từ [BaseNavigator].
abstract class BaseNavigator {
  final BuildContext context;

  BaseNavigator(this.context);

  /// Navigates to the specified route using GoRouter.
  void pop<T extends Object?>([T? result]) {
    GoRouter.of(context).pop(result);
  }

  /// Pops if possible, otherwise navigates to home.
  void popOrGoHome() {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
    } else {
      router.go(AppRouters.home);
    }
  }

  /// Pops the current route until the specified route is reached.
  void popUntilNamed(String name) {
    Navigator.popUntil(context, ModalRoute.withName(name));
  }

  Future<dynamic> goNamed(String name, {Object? extra}) async {
    return GoRouter.of(context).go(name, extra: extra);
  }

  /// Pushes a new route onto the navigator stack.
  Future<dynamic> pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Replaces the current route with a new one.
  Future<dynamic> pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Pushes a new page onto the navigator stack using a MaterialPageRoute.
  Future<dynamic> pushPage(Widget page) async {
    final context = AppRouters.navigationKey.currentContext;
    if (context == null) {
      return Future.error('Context is null');
    }
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
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
        content: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
          ),
          child: Center(
            child: Text(
              message,
              style: context.textThemes.body16Semi.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
