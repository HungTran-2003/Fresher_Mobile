part of 'quick_analysis_cubit.dart';

class QuickAnalysisState extends Equatable {
  final LoadStatus status;

  const QuickAnalysisState({this.status = LoadStatus.initial});

  QuickAnalysisState copyWith({LoadStatus? status}) {
    return QuickAnalysisState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
