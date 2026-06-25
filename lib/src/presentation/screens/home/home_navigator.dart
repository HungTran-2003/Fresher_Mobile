import 'package:crud_app/src/core/routes/base_navigator.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/data/models/product/product_model.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';

class HomeNavigator extends BaseNavigator {
  HomeNavigator(super.context);

  /// Clears navigation stack and redirects back to the welcome/login page
  void toLogin() {
    goNamed(AppRouters.welcome);
  }

  void toAddProduct() {
    pushNamed(AppRouters.addProduct);
  }

  Future<void> toProductDetail(ProductModel product) async {
    final result = await pushNamed(AppRouters.productDetail, extra: product);
    if (result == true) {
      // Logic to refresh home page if needed, though home page usually has its own BlocListener or onPop logic
    }
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
