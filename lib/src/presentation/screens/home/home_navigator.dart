import 'package:crud_app/src/core/routes/base_navigator.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'package:get/get.dart';

class HomeNavigator extends BaseNavigator {
  HomeNavigator([super.context]);

  void toLogin() {
    Get.offAllNamed(AppRouters.welcome);
  }

  void toAddProduct() {
    pushNamed(AppRouters.addProduct);
  }

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
