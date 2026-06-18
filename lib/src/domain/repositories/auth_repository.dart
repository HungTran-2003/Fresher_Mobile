import 'package:dart_either/dart_either.dart';
import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/models/account_model.dart';

abstract class AuthRepository {
  Future<Either<AppException, AccountModel>> login({
    required String taxIdOrId,
    required String username,
    required String password,
  });

  Future<Either<AppException, Map<String, String>>> getLastLogin();

  Future<void> logout();

  Future<void> relogin();
}
