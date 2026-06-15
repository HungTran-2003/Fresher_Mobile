import 'package:equatable/equatable.dart';
import 'package:finance/src/core/utils/extensions/either_extension.dart';
import 'package:finance/src/domain/models/enum/load_status.dart';
import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_account_navigator.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final AuthCubit authCubit;
  final AuthRepository authRepository;
  final CreateAccountNavigator navigator;

  CreateAccountCubit({
    required this.authCubit,
    required this.authRepository,
    required this.navigator,
  }) : super(const CreateAccountState());

  Future<void> signUp({
    required String fullName,
    required String email,
    required String mobileNumber,
    required String dob,
    required String password,
  }) async {
    if (state.status == LoadStatus.loading) return;
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await authRepository.signUp(
      email: email,
      password: password,
      userName: fullName,
      dod: dob,
      phoneNumber: mobileNumber,
    );
    return result.foldResult(
      onError: (failure) {
        emit(state.copyWith(status: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
      onSuccess: (user) {
        emit(state.copyWith(status: LoadStatus.success));
        authCubit.setAuthenticated(true);
      },
    );
  }
}
