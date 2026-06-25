part of 'setting_cubit.dart';

class SettingState extends Equatable {
  final LoadStatus status;

  const SettingState({
    this.status = LoadStatus.initial,
  });

  SettingState copyWith({
    LoadStatus? status,
  }) {
    return SettingState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
