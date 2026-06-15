import 'package:dart_either/dart_either.dart';
import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  @override
  Future<void> getCurrentUser() async {
    // TODO: get current User
  }

  @override
  Future<void> updateProfile(UserEntity user) async {
    // TODO: implement updateProfile
  }
}
