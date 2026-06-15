import 'package:equatable/equatable.dart';
import 'package:finance/src/data/response/transaction_response.dart';
import 'package:finance/src/domain/models/enum/filter_time.dart';
import 'package:finance/src/domain/models/enum/load_status.dart';
import 'package:finance/src/domain/repositories/transaction_repository.dart';
import 'package:finance/src/presentation/screens/home/home_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;
  final TransactionRepository transactionRepository;

  HomeCubit({required this.navigator, required this.transactionRepository})
    : super(const HomeState()) {
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    emit(state.copyWith(status: LoadStatus.loading));

    final groupBy = _mapFilterToGroupBy(state.selectedFilter.groupBy);

    final result = await transactionRepository.getTransactions(
      groupBy: groupBy,
    );
    result.fold(
      ifLeft: (exception) => emit(
        state.copyWith(
          status: LoadStatus.failure,
          errorMessage: exception.message,
        ),
      ),
      ifRight: (transactions) => emit(
        state.copyWith(status: LoadStatus.success, transactions: transactions),
      ),
    );
  }

  void changeFilter(FilterTime filter) {
    emit(state.copyWith(selectedFilter: filter));
    fetchTransactions();
  }

  String _mapFilterToGroupBy(String filter) {
    switch (filter) {
      case 'Daily':
        return 'day';
      case 'Weekly':
        return 'week';
      case 'Monthly':
      default:
        return 'month';
    }
  }
}
