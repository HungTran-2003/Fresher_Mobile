import 'dart:developer';
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
