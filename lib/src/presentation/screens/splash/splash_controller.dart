import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'package:crud_app/src/domain/usecases/auth/logout_use_case.dart';
import 'package:crud_app/src/domain/usecases/setting/setting_use_cases.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AuthController _authController;
  final UserController _userController;
  final LogoutUseCase _logoutUseCase;
  final CheckFirstRunUseCase _checkFirstRunUseCase;
  final SetFirstRunUseCase _setFirstRunUseCase;
  final SplashNavigator navigator;

  SplashController({
    required this.navigator,
    required AuthController authController,
    required UserController userController,
    required LogoutUseCase logoutUseCase,
    required CheckFirstRunUseCase checkFirstRunUseCase,
    required SetFirstRunUseCase setFirstRunUseCase,
  }) : _authController = authController,
       _userController = userController,
       _logoutUseCase = logoutUseCase,
       _checkFirstRunUseCase = checkFirstRunUseCase,
       _setFirstRunUseCase = setFirstRunUseCase;

  @override
  void onReady() {
    super.onReady();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));

    final Either<dynamic, bool> isFirstRunResult = await _checkFirstRunUseCase(
      NoParams(),
    );
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
    _logoutUseCase();
    await _setFirstRunUseCase(false);
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
      final taxIdOrId = parts[1];
      final timestampStr = parts.last;
      final timestamp = int.tryParse(timestampStr) ?? 0;
      final sessionTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final isExpired =
          DateTime.now().difference(sessionTime) > const Duration(hours: 30);

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
