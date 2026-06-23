import 'dart:developer';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/data/services/network/dio_interceptor.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:get/get.dart';
import 'auth_state.dart';

class AuthController extends GetxController {
  final AuthRepository authRepo;
  final state = AuthState();

  AuthController({required this.authRepo}) {
    CustomDioInterceptor.onUnauthorized = () async {
      return await relogin();
    };
  }

  @override
  void onInit() {
    super.onInit();
    _initAuthListener();
  }

  void _initAuthListener() {
    ever(state.isAuthenticated, (bool isAuthenticated) {
      if (isAuthenticated) {
        Get.offAllNamed(AppRouters.home);
      } else {
        Get.offAllNamed(AppRouters.welcome);
      }
    });
  }

  void setAuthenticated(bool isAuthenticated) {
    state.isAuthenticated.value = isAuthenticated;
    log('Auth status updated: isAuthenticated=$isAuthenticated');
  }

  void logout() {
    authRepo.logout();
    setAuthenticated(false);
  }

  Future<String> relogin() async {
    return authRepo.relogin();
  }
}
