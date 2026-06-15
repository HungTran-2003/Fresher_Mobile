part of 'welcome_cubit.dart';

class WelcomeState extends Equatable {
  final LoadStatus status;

  const WelcomeState({
    this.status = LoadStatus.initial,
  });


  WelcomeState copyWith({
    LoadStatus? status,
    String? errorMessage,
    bool? obscurePassword,
  }) {
    return WelcomeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
