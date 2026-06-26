import 'package:crud_app/src/core/routes/base_navigator.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:get/get.dart';

class SplashNavigator extends BaseNavigator {
  SplashNavigator([super.context]);

  Future<void> navigateToOnboard() async {
    Get.offAllNamed(AppRouters.onboarding);
  }

  void toHome() {
    Get.offAllNamed(AppRouters.home);
  }

  void toWelcome() {
    Get.offAllNamed(AppRouters.welcome);
  }
}
