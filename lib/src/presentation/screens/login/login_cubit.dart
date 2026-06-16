import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/core/utils/app_validators.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'login_navigator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthCubit _authCubit;
  final UserCubit _userCubit;
  final AuthRepository _authRepository;
  final LoginNavigator navigator;

  LoginCubit({
    required AuthCubit authCubit,
    required UserCubit userCubit,
    required AuthRepository authRepository,
    required this.navigator,
  })  : _authCubit = authCubit,
        _userCubit = userCubit,
        _authRepository = authRepository,
        super(const LoginState());

  /// Triggers on changes to the Tax ID / CCCD field to perform real-time validation
  void onTaxIdOrIdChanged(BuildContext context, String value) {
    if (state.isFirstSubmit) {
      final err = AppValidators.validateTaxIdOrId(context, value) ?? '';
      emit(state.copyWith(taxIdOrIdError: err));
    }
  }

  /// Triggers on changes to the Username field to perform real-time validation
  void onUsernameChanged(BuildContext context, String value) {
    if (state.isFirstSubmit) {
      final err = AppValidators.validateUsername(context, value) ?? '';
      emit(state.copyWith(usernameError: err));
    }
  }

  /// Triggers on changes to the Password field to perform real-time validation
  void onPasswordChanged(BuildContext context, String value) {
    if (state.isFirstSubmit) {
      final err = AppValidators.validateLoginPassword(context, value) ?? '';
      emit(state.copyWith(passwordError: err));
    }
  }

  /// Executes the Login process via AuthRepository
  Future<void> submitLogin(
    BuildContext context, {
    required String taxIdOrId,
    required String username,
    required String password,
  }) async {
    // 1. Mark as first submit and validate all fields
    final taxIdOrIdError = AppValidators.validateTaxIdOrId(context, taxIdOrId) ?? '';
    final usernameError = AppValidators.validateUsername(context, username) ?? '';
    final passwordError = AppValidators.validateLoginPassword(context, password) ?? '';

    if (taxIdOrIdError.isNotEmpty || usernameError.isNotEmpty || passwordError.isNotEmpty) {
      emit(state.copyWith(
        status: LoadStatus.failure,
        isFirstSubmit: true,
        taxIdOrIdError: taxIdOrIdError,
        usernameError: usernameError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(state.copyWith(
      status: LoadStatus.loading,
      isFirstSubmit: true,
      taxIdOrIdError: '',
      usernameError: '',
      passwordError: '',
    ));

    try {
      final result = await _authRepository.login(
        taxIdOrId: taxIdOrId,
        username: username,
        password: password,
      );

      result.fold(
        ifLeft: (failure) {
          log('Login failed: ${failure.message}');
          if (context.mounted) {
            _handleLoginFailure(context);
          }
        },
        ifRight: (account) {
          log('Login successful: ${account.username}');
          final user = UserEntity(
            id: taxIdOrId.trim(),
            userName: account.username,
            email: '',
            fullName: account.fullName,
          );
          _userCubit.updateUser(user);
          _authCubit.setAuthenticated(true);

          emit(state.copyWith(status: LoadStatus.success));
          navigator.toHome();
        },
      );
    } catch (e) {
      log('Login process encountered error: $e');
      if (context.mounted) {
        _handleLoginFailure(context);
      }
    }
  }

  void _handleLoginFailure(BuildContext context) {
    if (!context.mounted) return;
    emit(state.copyWith(status: LoadStatus.failure));
    navigator.showInvalidCredentialsDialog(
      title: context.s.loginErrorTitle,
      confirmText: context.s.closeButton,
    );
  }
}
