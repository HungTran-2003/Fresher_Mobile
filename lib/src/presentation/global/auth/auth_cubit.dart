import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo;

  AuthCubit({required this.authRepo}) : super(const AuthState());

  /// Update authentication status
  void setAuthenticated(bool isAuthenticated) {
    emit(state.copyWith(isAuthenticated: isAuthenticated));
    log('Auth status updated: isAuthenticated=$isAuthenticated');
  }
}
