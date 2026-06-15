import 'package:finance/src/core/routes/base_navigator.dart';
import 'package:finance/src/core/routes/router.dart';

class WelcomeNavigator extends BaseNavigator {
  WelcomeNavigator(super.context);

  void toHome() {
    goNamed(AppRouters.home);
  }

  void toCreateAccount() {
    pushNamed(AppRouters.createAccount);
  }

  void toForgotPassword() {
    pushNamed(AppRouters.forgotPassword);
  }
}
