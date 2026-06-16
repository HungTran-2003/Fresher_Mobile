import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:crud_app/src/data/models/account_model.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_navigator.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_either/dart_either.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthCubit _authCubit;
  final SettingRepository _settingRepository;
  final UserCubit _userCubit;
  final SecureStorageDataSource _secureStorageDataSource;
  final SplashNavigator navigator;

  SplashCubit(
    this.navigator,
    this._authCubit,
    this._userCubit,
    this._settingRepository,
    this._secureStorageDataSource,
  ) : super(const SplashState());

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      try {
        final Either<dynamic, bool> isFirstRunResult = await _settingRepository.isFirstRun();
        final isFirstRun = isFirstRunResult.fold(
          ifLeft: (_) => false,
          ifRight: (val) => val,
        );

        if (isFirstRun) {
          log('SplashCubit: First run detected. Clearing active session from secure storage if any...');
          await _secureStorageDataSource.clearSession();
          await _settingRepository.setFirstRun(isFirstRun: false);
        } else {
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
              final user = UserEntity(
                id: account.taxIdOrId,
                userName: account.username,
                email: '',
                fullName: account.fullName,
              );
              _userCubit.updateUser(user);
              _authCubit.setAuthenticated(true);
              return;
            }
          }
        }
      } catch (e) {
        log('SplashCubit: Failed to load session/firstRun: $e');
      }

      navigator.toWelcome();
    });
  }
}
