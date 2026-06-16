import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud_app/services/sync_service.dart';
import 'package:dart_either/dart_either.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'package:crud_app/services/crypto_service.dart';
import 'package:crud_app/models/account_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureStorageDataSource _secureStorageDataSource;

  AuthRepositoryImpl({
    required SecureStorageDataSource secureStorageDataSource,
  }) : _secureStorageDataSource = secureStorageDataSource;

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
        await SyncService.syncAccounts();
        return await _loginOnline(
          taxIdOrId: taxIdOrId,
          username: username,
          password: password,
        );
      }
    }

  Future<Either<AppException, AccountModel>> _loginOnline({
    required String taxIdOrId,
    required String username,
    required String password,
  }) async {
    final firestore = FirebaseFirestore.instance;

    var snapshot = await firestore
        .collection('accounts')
        .where('enabled', isEqualTo: true)
        .where('username', isEqualTo: username.trim())
        .where('taxIdOrId', arrayContains: taxIdOrId.trim())
        .get(const GetOptions(source: Source.server))
        .timeout(const Duration(seconds: 5));

    var docs = snapshot.docs;

    if (docs.isEmpty) {
      log('Login Online: Account not found or disabled on Firestore');
      return Left(ExceptionMapper.map(Exception("aaa")));
    }

    final account = AccountModel.fromJson(docs.first.data());

    final derivedKey = _getHashPassWord(password, account.salt);

    if (derivedKey != account.passwordHash) {
      log('Login Online: Password mismatch');
      return Left(ExceptionMapper.map(Exception("aaa")));
    }

    await _secureStorageDataSource.saveSession(
      username: account.username,
    );

    return Right(account);
  }

  /// Handles offline authentication using local Hive cache
  Future<Either<AppException, AccountModel>> _loginOffline({
    required String taxIdOrId,
    required String username,
    required String password,
  }) async {
    final box = Hive.box<AccountModel>('accountsBox');
    final key = "${taxIdOrId.trim()}_${username.trim()}";
    final localAccount = box.get(key);

    if (localAccount == null) {
      return Left(ExceptionMapper.map(Exception("aaa")));
    }

    if (!localAccount.enabled) {
      log('Login Offline: Account is disabled in Hive cache');
      return Left(ExceptionMapper.map(Exception("aaa")));
    }

    final derivedKey = _getHashPassWord(password, localAccount.salt);

    if (derivedKey != localAccount.passwordHash) {
      log('Login Offline: Password mismatch');
      return Left(ExceptionMapper.map(Exception("aaa")));
    }

    await _secureStorageDataSource.saveSession(
      username: localAccount.username,
    );

    return Right(localAccount);
  }

  String _getHashPassWord(String password, String salt){
    return CryptoService.hashPassword(
      password: password,
      saltBase64: salt,
      iterations: 100000,
    );
  }
}
