import 'package:dart_either/dart_either.dart';
import 'package:finance/src/core/exceptions/app_exception.dart';
import 'package:finance/src/domain/models/entities/user_entity.dart';

abstract class UserRepository {
  /// Lấy thông tin người dùng hiện tại
  Future<Either<AppException, UserEntity>> getCurrentUser();

  /// Cập nhật thông tin người dùng
  Future<void> updateProfile(UserEntity user);
}
