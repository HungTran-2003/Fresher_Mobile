import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/services/hive/auth/hive_service.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final HiveService _hiveService;

  UserRepositoryImpl({required HiveService hiveService})
    : _hiveService = hiveService;
  @override
  Future<Either<AppException, UserEntity>> getCurrentUser(
    String taxIdOrId,
    String username,
  ) async {
    final accounts = _hiveService.getAccount(taxIdOrId, username);
    try{
      final user = accounts?.toUserEntity();
      if(user != null){
        return Either.right(user);
      }
      return Either.left(ExceptionMapper.map(Exception('User not found')));
    } catch(e){
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<void> updateProfile(UserEntity user) async {
    // TODO: implement updateProfile
  }
}
