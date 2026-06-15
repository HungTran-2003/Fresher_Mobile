part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  final FilterTime selectedFilter;
  final List<TransactionResponse> transactions;
  final String? errorMessage;

  const HomeState({
    this.status = LoadStatus.initial,
    this.selectedFilter = FilterTime.day,
    this.transactions = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    LoadStatus? status,
    FilterTime? selectedFilter,
    List<TransactionResponse>? transactions,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedFilter,
    transactions,
    errorMessage,
  ];
}
