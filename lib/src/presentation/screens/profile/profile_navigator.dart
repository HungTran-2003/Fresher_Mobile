import '../../../core/routes/base_navigator.dart';
import '../../../core/routes/router.dart';

class ProfileNavigator extends BaseNavigator {
  ProfileNavigator(super.context);

  void back() {
    pop();
  }

  void toHome() {
    pushReplacementNamed(AppRouters.home);
  }

  void toQuickAnalysis() {
    pushReplacementNamed(AppRouters.quickAnalysis);
  }
}
