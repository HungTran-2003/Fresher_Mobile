import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'setting_navigator.dart';
import 'setting_state.dart';

class SettingController extends GetxController {
  final AuthController _authController;
  final AppSettingsController _appSettingsController;
  final SettingNavigator navigator;
  final state = SettingState();

  SettingController({
    required AuthController authController,
    required AppSettingsController appSettingsController,
    required this.navigator,
  }) : _authController = authController,
       _appSettingsController = appSettingsController;

  Future<void> toggleBiometrics(bool value) async {
    if (value) {
      final localAuth = LocalAuthentication();
      final isSupported = await localAuth.isDeviceSupported();
      final canCheck = await localAuth.canCheckBiometrics;
      if (isSupported && canCheck) {
        try {
          final authenticated = await localAuth.authenticate(
            localizedReason: S.current.biometricAuthReason,
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
            ),
          );
          if (authenticated) {
            _appSettingsController.changeUseBiometrics(useBiometrics: value);
          }
        } catch (e) {
          navigator.showErrorDialog(message: e.toString());
        }
      } else {
        await navigator.showErrorDialog(
          title: S.current.notificationTitle,
          message: S.current.biometricSetupFailed,
        );
      }
    } else {
      _appSettingsController.changeUseBiometrics(useBiometrics: value);
    }
  }

  Future<void> logout() async {
    final action = await navigator.showLogoutConfirmDialog(
      title: S.current.logoutConfirmTitle,
      message: S.current.logoutConfirmMessage,
      confirmText: S.current.okButton,
      declineText: S.current.cancelButton,
    );

    if (action == DialogAction.confirmed) {
      state.status.value = LoadStatus.loading;
      _authController.logout();
      _appSettingsController.changeUseBiometrics(useBiometrics: false);
      state.status.value = LoadStatus.success;
    }
  }
}
