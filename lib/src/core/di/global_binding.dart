import 'package:crud_app/src/data/services/hive/product/hive_product_service.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'package:crud_app/src/data/services/network/network_util.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crud_app/src/data/repositories/auth_repository_impl.dart';
import 'package:crud_app/src/data/repositories/product_repository_impl.dart';
import 'package:crud_app/src/data/repositories/setting_repository_impl.dart';
import 'package:crud_app/src/data/repositories/upload_repository_impl.dart';
import 'package:crud_app/src/data/repositories/user_repository_impl.dart';
import 'package:crud_app/src/data/services/firebase/auth/firebase_service.dart';
import 'package:crud_app/src/data/services/hive/auth/hive_service.dart';
import 'package:crud_app/src/data/services/network/dio_client.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';
import 'package:crud_app/src/domain/repositories/user_repository.dart';
import 'package:crud_app/src/domain/usecases/auth/logout_use_case.dart';
import 'package:crud_app/src/domain/usecases/auth/relogin_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_local_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/setting/setting_use_cases.dart';
import 'package:crud_app/src/domain/usecases/user/get_current_user_use_case.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put(NetworkService());
    Get.put(SecureStorageDataSource(const FlutterSecureStorage()));
    Get.put(HiveProductService());

    // Repositories
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        hiveService: HiveService(),
        firebaseService: FirebaseService(),
      ),
      fenix: true,
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(hiveService: HiveService()),
      fenix: true,
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        dioClient: DioClient.instance,
        hiveService: Get.find<HiveProductService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SettingRepository>(() => SettingRepositoryImpl(), fenix: true);
    Get.lazyPut<UploadRepository>(() => UploadRepositoryImpl(), fenix: true);

    // UseCases
    Get.lazyPut(() => LogoutUseCase(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => ReloginUseCase(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => GetRemoteProductsUseCase(Get.find<ProductRepository>()),
        fenix: true);
    Get.lazyPut(() => GetLocalProductsUseCase(Get.find<ProductRepository>()),
        fenix: true);
    Get.lazyPut(() => GetCurrentUserUseCase(Get.find<UserRepository>()),
        fenix: true);
    Get.lazyPut(() => GetLanguageUseCase(Get.find<SettingRepository>()),
        fenix: true);
    Get.lazyPut(() => SetLanguageUseCase(Get.find<SettingRepository>()),
        fenix: true);
    Get.lazyPut(() => GetThemeModeUseCase(Get.find<SettingRepository>()),
        fenix: true);
    Get.lazyPut(() => SetThemeModeUseCase(Get.find<SettingRepository>()),
        fenix: true);
    Get.lazyPut(() => GetBiometricsUseCase(Get.find<SettingRepository>()),
        fenix: true);
    Get.lazyPut(() => SetBiometricsUseCase(Get.find<SettingRepository>()),
        fenix: true);

    // Global Controllers
    Get.put(
      AuthController(
        logoutUseCase: Get.find<LogoutUseCase>(),
        reloginUseCase: Get.find<ReloginUseCase>(),
      ),
      permanent: true,
    );
    Get.put(UserController(Get.find<GetCurrentUserUseCase>()), permanent: true);
    Get.put(
      AppSettingsController(
        getLanguageUseCase: Get.find<GetLanguageUseCase>(),
        setLanguageUseCase: Get.find<SetLanguageUseCase>(),
        getThemeModeUseCase: Get.find<GetThemeModeUseCase>(),
        setThemeModeUseCase: Get.find<SetThemeModeUseCase>(),
        getBiometricsUseCase: Get.find<GetBiometricsUseCase>(),
        setBiometricsUseCase: Get.find<SetBiometricsUseCase>(),
      ),
      permanent: true,
    );
  }
}
