import 'package:equatable/equatable.dart';
import 'package:finance/src/domain/models/enum/load_status.dart';
import 'package:finance/src/domain/repositories/setting_repository.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:finance/src/presentation/global/user/user_cubit.dart';
import 'package:finance/src/presentation/screens/splash/splash_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      final isLogin = _authCubit.authRepo.isUserLoggedIn;
      if (isLogin) {
        await _userCubit.getUser();
        _authCubit.setAuthenticated(true);
        return;
      }

      final isFirstRunResult = await _settingRepository.isFirstRun();
      final isFirstRun = isFirstRunResult.getOrElse(() => false);

      if (isFirstRun) {
        navigator.toWelcome();
      } else {
        navigator.navigateToOnboard();
      }
    });
  }
}
