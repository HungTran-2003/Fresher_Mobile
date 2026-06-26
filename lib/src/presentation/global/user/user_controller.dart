import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/domain/usecases/user/get_current_user_use_case.dart';
import 'package:get/get.dart';
import 'user_state.dart';

class UserController extends GetxController {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final state = UserState();

  UserController(this._getCurrentUserUseCase);

  Future<void> getUser(String taxIdOrId, String username) async {
    final result = await _getCurrentUserUseCase(GetCurrentUserParams(
      taxIdOrId: taxIdOrId,
      username: username,
    ));
    result.foldResult(onError: (_) {}, onSuccess: (user) => updateUser(user));
  }

  void updateUser(UserEntity user) {
    state.user.value = user;
  }
}
