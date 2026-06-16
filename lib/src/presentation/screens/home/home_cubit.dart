import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

import 'package:crud_app/models/account_model.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'home_navigator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthCubit _authCubit;
  final UserCubit _userCubit;
  final SecureStorageDataSource _secureStorageDataSource;
  final HomeNavigator navigator;

  HomeCubit({
    required AuthCubit authCubit,
    required UserCubit userCubit,
    required SecureStorageDataSource secureStorageDataSource,
    required this.navigator,
  })  : _authCubit = authCubit,
        _userCubit = userCubit,
        _secureStorageDataSource = secureStorageDataSource,
        super(const HomeState());

  Future<void> init() async {
    try {
      final user = _userCubit.state.user;
      if (user != null) {
        emit(state.copyWith(
          username: user.userName,
          fullName: user.fullName ?? '',
        ));
        return;
      }

      final token = await _secureStorageDataSource.getSessionToken();
      if (token != null) {
        final parts = token.split('_');
        final username = parts.first;

        final box = Hive.box<AccountModel>('accountsBox');
        AccountModel? account;
        for (final acc in box.values) {
          if (acc.username == username) {
            account = acc;
            break;
          }
        }

        if (account != null) {
          emit(state.copyWith(
            username: account.username,
            fullName: account.fullName,
          ));
        }
      }
    } catch (e) {
      log('HomeCubit: Failed to load user session: $e');
    }
  }

  /// Handles user logout flow with a confirmation popup dialog
  Future<void> logout(BuildContext context) async {
    final action = await navigator.showLogoutConfirmDialog(
      title: context.s.logoutConfirmTitle,
      message: context.s.logoutConfirmMessage,
      confirmText: context.s.okButton,
      declineText: context.s.cancelButton,
    );

    if (action == DialogAction.confirmed) {
      emit(state.copyWith(status: LoadStatus.loading));
      
      try {
        // Clear secure storage session keys
        await _secureStorageDataSource.clearSession();

        // Update global cubits authentication state
        _userCubit.updateUser(const UserEntity(id: '', userName: '', email: ''));
        _authCubit.setAuthenticated(false);

        emit(state.copyWith(status: LoadStatus.success));

        // Navigate back to Login page
        navigator.toLogin();
      } catch (e) {
        log('HomeCubit: Logout failed: $e');
        emit(state.copyWith(status: LoadStatus.failure));
      }
    }
  }
}
