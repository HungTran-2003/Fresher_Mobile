import 'package:dart_either/dart_either.dart';
import 'package:finance/src/core/exceptions/app_exception.dart';
import 'package:finance/src/domain/models/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<Either<AppException, UserEntity>> getCurrentUser() async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) {
        return Left(ExceptionMapper.map(Exception('User null')));
      }
      final response = await _client
          .from('user_info')
          .select()
          .eq('id', currentUser.id)
          .single();
      return Right(UserEntity.fromJson(response));
    } catch (e) {
      return Left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<void> updateProfile(UserEntity user) async {
    // TODO: implement updateProfile
  }
}
