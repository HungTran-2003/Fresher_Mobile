import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/screens/home/home_controller.dart';
import 'package:crud_app/src/presentation/screens/home/home_navigator.dart';
import 'package:crud_app/src/presentation/screens/main/main_controller.dart';
import 'package:crud_app/src/presentation/screens/setting/setting_controller.dart';
import 'package:crud_app/src/presentation/screens/setting/setting_navigator.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());

    Get.lazyPut(
      () => HomeController(
        productRepository: Get.find<ProductRepository>(),
        navigator: HomeNavigator(),
      ),
    );

    Get.lazyPut(
      () => SettingController(
        authController: Get.find<AuthController>(),
        appSettingsController: Get.find<AppSettingsController>(),
        navigator: SettingNavigator(),
      ),
    );
  }
}
