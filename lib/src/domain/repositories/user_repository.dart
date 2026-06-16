
import 'package:crud_app/src/domain/models/entities/user_entity.dart';

abstract class UserRepository {
  /// Lấy thông tin người dùng hiện tại
  Future<void> getCurrentUser();

  /// Cập nhật thông tin người dùng
  Future<void> updateProfile(UserEntity user);
}
