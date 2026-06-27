import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/product/delete_product_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_local_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/process_products_use_case.dart';
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

    // UseCases for Home
    Get.lazyPut(() => GetRemoteProductsUseCase(Get.find<ProductRepository>()));
    Get.lazyPut(() => GetLocalProductsUseCase(Get.find<ProductRepository>()));
    Get.lazyPut(() => GetCategoriesUseCase(Get.find<ProductRepository>()));
    Get.lazyPut(() => DeleteProductUseCase(Get.find<ProductRepository>()));
    Get.lazyPut(() => ProcessProductsUseCase());

    Get.lazyPut(
      () => HomeController(
        getRemoteProductsUseCase: Get.find<GetRemoteProductsUseCase>(),
        getLocalProductsUseCase: Get.find<GetLocalProductsUseCase>(),
        getCategoriesUseCase: Get.find<GetCategoriesUseCase>(),
        deleteProductUseCase: Get.find<DeleteProductUseCase>(),
        processProductsUseCase: Get.find<ProcessProductsUseCase>(),
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
