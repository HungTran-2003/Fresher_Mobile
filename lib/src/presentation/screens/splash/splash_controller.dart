import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AuthController _authController;
  final SettingRepository _settingRepository;
  final UserController _userController;
  final SplashNavigator navigator;

  SplashController({
    required this.navigator,
    required AuthController authController,
    required UserController userController,
    required SettingRepository settingRepository,
  }) : _authController = authController,
       _userController = userController,
       _settingRepository = settingRepository;

  @override
  void onReady() {
    super.onReady();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    
    final Either<dynamic, bool> isFirstRunResult = await _settingRepository.isFirstRun();
    final isFirstRun = isFirstRunResult.fold(
      ifLeft: (_) => false,
      ifRight: (val) => val,
    );

    if (isFirstRun) {
      await _handleFirstRun();
    } else {
      await _handleReturningUser();
    }
  }

  Future<void> _handleFirstRun() async {
    _authController.logout();
    await _settingRepository.setFirstRun(isFirstRun: false);
  }

  Future<void> _handleReturningUser() async {
    final token = await SecureStorageDataSource.instance.getSessionToken();

    if (token == null) {
      _authController.setAuthenticated(false);
      return;
    }
    try {
      final parts = token.split('_');
      final username = parts.first;
      final taxIdOrId = parts[2];
      final timestampStr = parts.last;
      final timestamp = int.tryParse(timestampStr) ?? 0;
      final sessionTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final isExpired =
          DateTime.now().difference(sessionTime) > const Duration(minutes: 30);

      if (!isExpired) {
        _autoLogin(taxIdOrId, username);
      } else {
        await _forceReLogin();
      }
    } catch (e) {
      await _forceReLogin();
    }
  }

  void _autoLogin(String taxIdOrId, String username) {
    _userController.getUser(taxIdOrId, username);
    _authController.setAuthenticated(true);
  }

  Future<void> _forceReLogin() async {
    _authController.setAuthenticated(false);
  }
}
