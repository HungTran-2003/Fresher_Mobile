import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/usecases/auth/get_last_login_use_case.dart';
import 'package:crud_app/src/domain/usecases/auth/login_use_case.dart';
import 'package:crud_app/src/domain/usecases/auth/relogin_use_case.dart';
import 'package:crud_app/src/domain/usecases/setting/setting_use_cases.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'login_navigator.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginNavigator(Get.context!));
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => GetLastLoginUseCase(Get.find<AuthRepository>()));

    Get.lazyPut(
      () => LoginController(
        authController: Get.find<AuthController>(),
        userController: Get.find<UserController>(),
        loginUseCase: Get.find<LoginUseCase>(),
        getLastLoginUseCase: Get.find<GetLastLoginUseCase>(),
        getBiometricsUseCase: Get.find<GetBiometricsUseCase>(),
        reloginUseCase: Get.find<ReloginUseCase>(),
        navigator: Get.find<LoginNavigator>(),
      ),
    );
  }
}
