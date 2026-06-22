import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'login_navigator.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
          authController: Get.find<AuthController>(),
          userController: Get.find<UserController>(),
          authRepository: Get.find<AuthRepository>(),
          settingRepository: Get.find<SettingRepository>(),
          navigator: LoginNavigator(),
        ));
  }
}
