import 'package:dart_either/dart_either.dart';
import 'package:finance/src/core/exceptions/app_exception.dart';
import 'package:finance/src/core/utils/extensions/logger.dart';
import 'package:finance/src/data/response/transaction_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final SupabaseClient _client = Supabase.instance.client;

  TransactionRepositoryImpl();

  @override
  Future<Either<AppException, List<TransactionResponse>>> getTransactions({
    String groupBy = 'day',
  }) async {
    try {
      logger.d('id: ${_client.auth.currentUser!.id}');
      final response = await _client.rpc(
        'get_transactions_grouped',
        params: {
          'p_user_id': _client.auth.currentUser!.id,
          'p_group_by': groupBy,
        },
      );
      return Right(
        (response as List).map((e) => TransactionResponse.fromJson(e)).toList(),
      );
    } catch (e) {
      return Left(ExceptionMapper.map(e));
    }
  }

  // @override
  // Future<void> addTransaction(Transaction transaction) {}
  //
  // @override
  // Future<void> deleteTransaction(String id) {
  //   return;
  // }
}
