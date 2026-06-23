import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';
import 'splash_navigator.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(
        navigator: SplashNavigator(),
        authController: Get.find<AuthController>(),
        userController: Get.find<UserController>(),
        settingRepository: Get.find<SettingRepository>(),
      ),
    );
  }
}
