import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/domain/usecases/auth/logout_use_case.dart';
import 'package:crud_app/src/domain/usecases/setting/setting_use_cases.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';
import 'splash_navigator.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashNavigator(Get.context!));
    Get.lazyPut(() => CheckFirstRunUseCase(Get.find<SettingRepository>()));
    Get.lazyPut(() => SetFirstRunUseCase(Get.find<SettingRepository>()));

    Get.lazyPut(
      () => SplashController(
        navigator: Get.find<SplashNavigator>(),
        authController: Get.find<AuthController>(),
        userController: Get.find<UserController>(),
        logoutUseCase: Get.find<LogoutUseCase>(),
        checkFirstRunUseCase: Get.find<CheckFirstRunUseCase>(),
        setFirstRunUseCase: Get.find<SetFirstRunUseCase>(),
      ),
    );
  }
}
