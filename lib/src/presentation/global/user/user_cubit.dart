import 'package:equatable/equatable.dart';
import 'package:finance/src/core/utils/extensions/either_extension.dart';
import 'package:finance/src/domain/models/entities/user_entity.dart';
import 'package:finance/src/domain/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserState());

  Future<void> getUser() async {
    final result = await _userRepository.getCurrentUser();
    result.foldResult(
      onSuccess: (user) {
        emit(state.copyWith(user: user));
      },
      onError: (failure) {},
    );
  }

  void updateUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }
}
