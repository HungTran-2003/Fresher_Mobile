import '../../../core/routes/base_navigator.dart';
import '../../../core/routes/router.dart';

class QuickAnalysisNavigator extends BaseNavigator {
  QuickAnalysisNavigator(super.context);

  void back() {
    pop();
  }

  void toProfile() {
    pushNamed(AppRouters.profile);
  }
}
