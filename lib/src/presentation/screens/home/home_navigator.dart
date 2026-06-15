import '../../../core/routes/base_navigator.dart';
import '../../../core/routes/router.dart';

class HomeNavigator extends BaseNavigator {
  HomeNavigator(super.context);

  void back() {
    pop();
  }

  void toQuickAnalysis() {
    pushNamed(AppRouters.quickAnalysis);
  }

  void toProfile() {
    pushNamed(AppRouters.profile);
  }
}
