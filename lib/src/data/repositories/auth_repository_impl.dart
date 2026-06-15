import 'package:dart_either/dart_either.dart';
import 'package:finance/configs/app_config.dart';
import 'package:finance/src/core/exceptions/app_exception.dart';
import 'package:finance/src/core/utils/extensions/logger.dart';
import 'package:finance/src/domain/models/entities/user_entity.dart';
import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<Either<AppException, UserEntity>> signUp({
    required String email,
    required String password,
    required String userName,
    String? dod,
    String? phoneNumber,
  }) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'user_name': userName,
          'date_of_birth': dod,
          'phone_number': phoneNumber,
        },
      );

      if (currentUser == null) {
        return Left(ExceptionMapper.map(Exception('User null')));
      }
      final response = await _client
          .from('user_info')
          .select()
          .eq('id', currentUser!.id)
          .single();
      return Right(UserEntity.fromJson(response));
    } catch (e) {
      return Left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, UserEntity>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      if (currentUser == null) {
        return Left(ExceptionMapper.map(Exception('User null')));
      }
      final response = await _client
          .from('user_info')
          .select()
          .eq('id', currentUser!.id)
          .single();
      return Right(UserEntity.fromJson(response));
    } catch (e) {
      return Left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<void> logOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<Either<AppException, UserEntity>> signInWithGoogle() async {
    try {
      final scopes = ['email', 'profile'];
      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId: AppConfigs.webClientId,
        clientId: AppConfigs.iosClientId,
      );
      final googleUser = await googleSignIn.authenticate();

      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes) ??
          await googleUser.authorizationClient.authorizeScopes(scopes);
      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        throw AuthException('No ID Token found.');
      }
      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
      if (currentUser == null) {
        return Left(ExceptionMapper.map(Exception('User null')));
      }
      final response = await _client
          .from('user_info')
          .select()
          .eq('id', currentUser!.id)
          .single();
      return Right(UserEntity.fromJson(response));
    } catch (e) {
      logger.e(e.toString());
      return Left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'financeflow://welcome',
    );
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _client.auth.updateUser(UserAttributes(password: newPassword));
  }

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  bool get isUserLoggedIn => _client.auth.currentSession != null;
}
