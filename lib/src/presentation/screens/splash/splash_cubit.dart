import 'package:equatable/equatable.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_navigator.dart';
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

  }
}
