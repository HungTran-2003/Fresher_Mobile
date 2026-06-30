import 'dart:developer';

import 'package:crud_app/src/data/services/network/dio_interceptor.dart';
import 'package:equatable/equatable.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo;

  AuthCubit({required this.authRepo}) : super(const AuthState()) {
    CustomDioInterceptor.onUnauthorized = () async {
     return await relogin();
    };
  }

  /// Update authentication status
  void setAuthenticated(bool isAuthenticated) {
    emit(state.copyWith(isAuthenticated: isAuthenticated));
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
