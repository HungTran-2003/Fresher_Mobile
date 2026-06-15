import 'package:dart_either/dart_either.dart';
import 'package:finance/src/core/exceptions/app_exception.dart';
import 'package:finance/src/domain/models/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Either<AppException, UserEntity>> signUp({
    required String email,
    required String password,
    required String userName,
    String? dod,
    String? phoneNumber,
  });

  Future<Either<AppException, UserEntity>> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<Either<AppException, UserEntity>> signInWithGoogle();

  Future<void> resetPassword(String email);

  Future<void> updatePassword(String newPassword);

  User? get currentUser;

  bool get isUserLoggedIn;
}
