import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/domain/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'user_state.dart';

class UserController extends GetxController {
  final UserRepository _userRepository;
  final state = UserState();

  UserController(this._userRepository);

  Future<void> getUser(String taxIdOrId, String username) async {
    final result = await _userRepository.getCurrentUser(taxIdOrId, username);
    result.foldResult(
      onError: (_) {},
      onSuccess: (user) => updateUser(user),
    );
  }

  void updateUser(UserEntity user) {
    state.user.value = user;
  }
}
