import 'package:crud_app/src/core/routes/base_navigator.dart';
import 'package:crud_app/src/core/routes/router.dart';

class SplashNavigator extends BaseNavigator {
  SplashNavigator(super.context);

  Future<void> navigateToOnboard() async {
    goNamed(AppRouters.onboarding);
  }

  void toHome() {
    goNamed(AppRouters.home);
  }

  void toWelcome() {
    goNamed(AppRouters.welcome);
  }
}
