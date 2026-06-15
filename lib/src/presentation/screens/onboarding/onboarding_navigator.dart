import 'package:finance/src/core/routes/base_navigator.dart';
import 'package:finance/src/core/routes/router.dart';

class OnboardingNavigator extends BaseNavigator {
  OnboardingNavigator(super.context);

  void toDashboard() {
    pushReplacementNamed(AppRouters.welcome);
  }
}
