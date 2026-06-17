import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/data/services/database/share_preferrences_data_source.dart';
import 'package:crud_app/src/data/services/firebase/auth/sync_service.dart';
import 'package:dart_either/dart_either.dart';
import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'package:crud_app/src/data/services/hive/auth/hive_service.dart';
import 'package:crud_app/src/data/services/firebase/auth/firebase_service.dart';
import 'package:crud_app/src/core/utils/crypto_util.dart';
import 'package:crud_app/src/data/models/account_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final HiveService _hiveService;
  final FirebaseService _firebaseService;

  AuthRepositoryImpl({
    required HiveService hiveService,
    required FirebaseService firebaseService,
  })  :_hiveService = hiveService,
        _firebaseService = firebaseService;

  @override
  Future<Either<AppException, AccountModel>> login({
    required String taxIdOrId,
    required String username,
    required String password,
  }) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return await _loginOffline(
        taxIdOrId: taxIdOrId,
        username: username,
        password: password,
      );
    } else {
      try {
        await SyncService.syncAccounts(
          hiveService: _hiveService,
          firebaseService: _firebaseService,
        );
        return await _loginOnline(
          taxIdOrId: taxIdOrId,
          username: username,
          password: password,
        );
      } catch (e) {
        return Left(ExceptionMapper.map(e));
      }
    }
  }

  @override
  Future<Either<AppException, Map<String, String>>> getLastLogin() async {
    try {
      final taxIdOrId = SharedPreferencesDataSource.instance.getLastTaxIdOrId();
      final username = SharedPreferencesDataSource.instance.getLastUsername();
      return Either.right({
        'taxIdOrId': taxIdOrId,
        'username': username,
      });
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<void> logout() async {
    await SecureStorageDataSource.instance.clearSession();
    await SharedPreferencesDataSource.instance.clearLastLogin();
    await SharedPreferencesDataSource.instance.setUseBiometrics(false);
  }

  Future<Either<AppException, AccountModel>> _loginOnline({
    required String taxIdOrId,
    required String username,
    required String password,
  }) async {
    final docSnapshot = await _firebaseService.queryAccountDoc(taxIdOrId, username);

    if (docSnapshot == null) {
      return Left(ExceptionMapper.map(Exception(S.current.loginErrorTitle)));
    }

    final docRef = docSnapshot.reference;
    final account = AccountModel.fromJson(docSnapshot.data()!);

    return _handleAuthentication(
      account: account,
      password: password,
      onFailed: (attempts, lockUntil) =>
          _firebaseService.updateFailedAttempts(docRef, attempts, lockUntil),
      onSuccess: () => _firebaseService.resetFailedAttempts(docRef),
    );
  }

  Future<Either<AppException, AccountModel>> _loginOffline({
    required String taxIdOrId,
    required String username,
    required String password,
  }) async {
    final localAccount = _hiveService.getAccount(taxIdOrId, username);

    if (localAccount == null) {
      return Left(ExceptionMapper.map(Exception(S.current.loginErrorTitle)));
    }

    return _handleAuthentication(
      account: localAccount,
      password: password,
    );
  }

  Future<Either<AppException, AccountModel>> _handleAuthentication({
    required AccountModel account,
    required String password,
    Future<void> Function(int attempts, DateTime? lockUntil)? onFailed,
    Future<void> Function()? onSuccess,
  }) async {
    // Check if account is currently locked
    if (account.lockUntil != null && DateTime.now().isBefore(account.lockUntil!)) {
      return Left(UnknownException(message: S.current.accountLockedError));
    }

    final derivedKey = _getHashPassWord(password, account.salt);

    if (derivedKey != account.passwordHash) {
      final newFailedAttempts = (account.failedAttempts ?? 0) + 1;
      final newLockUntil = newFailedAttempts >= 5
          ? DateTime.now().add(const Duration(minutes: 5))
          : null;

      if (onFailed != null) {
        try {
          await onFailed(newFailedAttempts, newLockUntil);
        } catch (_) {
          // Fallback: Remote update failed
        }
      }

      // Update Hive cache
      final updatedAccount = account.copyWith(
        updatedAt: DateTime.now(),
        failedAttempts: newFailedAttempts,
        lockUntil: newLockUntil,
      );
      await _hiveService.saveAccount(updatedAccount);

      if (newFailedAttempts >= 5) {
        return Left(UnknownException(message: S.current.accountLockedError));
      }
      return Left(ExceptionMapper.map(Exception(S.current.loginErrorTitle)));
    }

    // Reset failedAttempts and lockUntil on successful login
    if (onSuccess != null && ((account.failedAttempts ?? 0) > 0 || account.lockUntil != null)) {
      try {
        await onSuccess();
      } catch (_) {
        // Fallback: Remote reset failed
      }
    }

    // Update Hive cache
    final updatedAccount = account.copyWith(
      updatedAt: DateTime.now(),
      failedAttempts: 0,
      lockUntil: null,
    );
    await _hiveService.saveAccount(updatedAccount);

    await SecureStorageDataSource.instance.saveSession(
      username: account.username,
      taxIdOrId: account.taxIdOrId
    );

    return Right(account);
  }

  String _getHashPassWord(String password, String salt) {
    return CryptoUtil.hashPassword(
      password: password,
      saltBase64: salt,
      iterations: 100000,
    );
  }
}
