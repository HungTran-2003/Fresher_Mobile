import 'package:equatable/equatable.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_navigator.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_either/dart_either.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthCubit _authCubit;
  final SettingRepository _settingRepository;
  final UserCubit _userCubit;
  final SplashNavigator navigator;

  SplashCubit(
    this.navigator,
    this._authCubit,
    this._userCubit,
    this._settingRepository,
  ) : super(const SplashState());

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 1)).then((_) async {
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
    });
  }

  Future<void> _handleFirstRun() async {
    _authCubit.logout();
    await _settingRepository.setFirstRun(isFirstRun: false);
    navigator.toWelcome();
  }

  Future<void> _handleReturningUser() async {
    final token = await SecureStorageDataSource.instance.getSessionToken();

    if (token == null) {
      navigator.toWelcome();
      return;
    }
    try{
      final parts = token.split('_');
      final username = parts.first;
      final taxIdOrId = parts[2];
      final timestampStr = parts.last;
      final timestamp = int.tryParse(timestampStr) ?? 0;
      final sessionTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final isExpired = DateTime.now().difference(sessionTime) > const Duration(minutes: 30);


      if (!isExpired) {
        _autoLogin(taxIdOrId, username);
      } else {
        await _forceReLogin();
      }
    } catch(e){
      await _forceReLogin();
    }
  }

  void _autoLogin(String taxIdOrId, String username) {
    _userCubit.getUser(taxIdOrId, username);
    _authCubit.setAuthenticated(true);
  }

  Future<void> _forceReLogin() async {
    await SecureStorageDataSource.instance.getSessionToken();
    navigator.toWelcome();
  }
}
