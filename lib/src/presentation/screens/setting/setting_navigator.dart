import 'package:crud_app/src/core/routes/base_navigator.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';

class SettingNavigator extends BaseNavigator {
  SettingNavigator(super.context);

  /// Clears navigation stack and redirects back to the welcome/login page
  void toLogin() {
    goNamed(AppRouters.welcome);
  }

  /// Displays the confirmation dialog for logout confirmation
  Future<DialogAction> showLogoutConfirmDialog({
    required String title,
    required String message,
    required String confirmText,
    required String declineText,
  }) async {
    return await AppDialog.show(
      context: context,
      dialogType: DialogType.infoConfirmation,
      titleText: title,
      messageText: message,
      confirmButtonText: confirmText,
      declineButtonText: declineText,
    );
  }
}
