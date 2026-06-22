import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'setting_controller.dart';
import 'setting_navigator.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController(
          authController: Get.find<AuthController>(),
          appSettingsController: Get.find<AppSettingsController>(),
          navigator: SettingNavigator(),
        ));
  }
}
