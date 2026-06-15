import 'package:finance/src/core/routes/base_navigator.dart';
import 'package:finance/src/core/routes/router.dart';

class ForgotPasswordNavigator extends BaseNavigator {
  ForgotPasswordNavigator(super.context);

  void back() {
    pop();
  }

  void toWelcome() {
    pop();
  }

  void toCreateAccount() {
    pushNamed(AppRouters.createAccount);
  }
}
