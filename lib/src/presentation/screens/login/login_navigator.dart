import 'package:crud_app/src/core/routes/base_navigator.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'package:flutter/material.dart';

class LoginNavigator extends BaseNavigator {
  LoginNavigator(super.context);

  /// Navigates to the Home page after successful authentication
  void toHome() {
    goNamed(AppRouters.home);
  }

  /// Displays the "Thông tin đăng nhập không hợp lệ" error alert dialog
  Future<void> showInvalidCredentialsDialog({
    required String title,
    required String confirmText,
  }) async {
    await AppDialog.show(
      context: context,
      dialogType: DialogType.errorAlert,
      titleText: title,
      messageText: '',
      confirmButtonText: confirmText,
    );
  }
}
