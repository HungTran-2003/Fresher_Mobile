import 'package:finance/src/core/routes/base_navigator.dart';
import 'package:finance/src/core/routes/router.dart';

class CreateAccountNavigator extends BaseNavigator {
  CreateAccountNavigator(super.context);

  void toHome() {
    goNamed(AppRouters.home);
  }

  void backToLogin() {
    pop();
  }
}
