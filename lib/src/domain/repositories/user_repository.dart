import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class UserRepository {
  /// Lấy thông tin người dùng hiện tại
  Future<Either<AppException, UserEntity>> getCurrentUser(
    String taxIdOrId,
    String username,
  );

  /// Cập nhật thông tin người dùng
  Future<void> updateProfile(UserEntity user);
}
