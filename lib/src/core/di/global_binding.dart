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
import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
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
      () => ProductRepositoryImpl(dioClient: DioClient.instance),
      fenix: true,
    );
    Get.lazyPut<SettingRepository>(() => SettingRepositoryImpl(), fenix: true);
    Get.lazyPut<UploadRepository>(() => UploadRepositoryImpl(), fenix: true);

    // Global Controllers
    Get.put(
      AuthController(authRepo: Get.find<AuthRepository>()),
      permanent: true,
    );
    Get.put(UserController(Get.find<UserRepository>()), permanent: true);
    Get.put(
      AppSettingsController(settingRepository: Get.find<SettingRepository>()),
      permanent: true,
    );
  }
}
