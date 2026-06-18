import 'package:crud_app/src/presentation/global/app_settings/app_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'setting_navigator.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final AuthCubit _authCubit;
  final AppSettingsCubit _appSettingsCubit;
  final SettingNavigator navigator;

  SettingCubit({
    required AuthCubit authCubit,
    required AppSettingsCubit appSettingsCubit,
    required this.navigator,
  })  : _authCubit = authCubit,
        _appSettingsCubit = appSettingsCubit,
        super(const SettingState());

  Future<void> toggleBiometrics(bool value) async {
    if (value) {
      final localAuth = LocalAuthentication();
      final isSupported = await localAuth.isDeviceSupported();
      final canCheck = await localAuth.canCheckBiometrics;
      if (isSupported && canCheck) {
        try {
          final authenticated = await localAuth.authenticate(
            localizedReason: 'Xác thực để bật đăng nhập sinh trắc học',
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
            ),
          );
          if (authenticated) {
            _appSettingsCubit.changeUseBiometrics(useBiometrics: value);
          }
        } catch (e) {
          navigator.showErrorDialog(message: e.toString());
        }
      } else {
        await navigator.showErrorDialog(
          title: 'Thông báo',
          message: 'Thiết bị không hỗ trợ hoặc chưa cài đặt sinh trắc học.',
        );
      }
    } else {
      _appSettingsCubit.changeUseBiometrics(useBiometrics: value);
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
      _authCubit.logout();
      _appSettingsCubit.changeUseBiometrics(useBiometrics: false);
      emit(state.copyWith(status: LoadStatus.success));
      navigator.toLogin();
    }
  }
}
