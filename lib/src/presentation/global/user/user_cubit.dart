import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/domain/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserState());

  Future<void> getUser(String taxIdOrId, String username) async {
    final result = await _userRepository.getCurrentUser(taxIdOrId, username);
    result.foldResult(
      onError: (_){},
      onSuccess: (user) => updateUser(user),
    );
  }

  void updateUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }
}
