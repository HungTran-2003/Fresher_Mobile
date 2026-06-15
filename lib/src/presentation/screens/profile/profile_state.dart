part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final LoadStatus status;

  const ProfileState({this.status = LoadStatus.initial});

  ProfileState copyWith({LoadStatus? status}) {
    return ProfileState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
