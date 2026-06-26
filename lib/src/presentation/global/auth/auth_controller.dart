import 'dart:developer';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/data/services/network/dio_interceptor.dart';
import 'package:crud_app/src/domain/usecases/auth/logout_use_case.dart';
import 'package:crud_app/src/domain/usecases/auth/relogin_use_case.dart';
import 'package:get/get.dart';
import 'auth_state.dart';

class AuthController extends GetxController {
  final LogoutUseCase _logoutUseCase;
  final ReloginUseCase _reloginUseCase;
  final state = AuthState();

  AuthController({
    required LogoutUseCase logoutUseCase,
    required ReloginUseCase reloginUseCase,
  }) : _logoutUseCase = logoutUseCase,
       _reloginUseCase = reloginUseCase {
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
    _logoutUseCase();
    setAuthenticated(false);
  }

  Future<String> relogin() async {
    return _reloginUseCase();
  }
}
