part of 'create_account_cubit.dart';

class CreateAccountState extends Equatable {
  final LoadStatus status;

  const CreateAccountState({this.status = LoadStatus.initial});

  CreateAccountState copyWith({LoadStatus? status}) {
    return CreateAccountState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
