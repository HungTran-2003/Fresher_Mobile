import 'package:dart_either/dart_either.dart';
import 'package:finance/src/core/exceptions/app_exception.dart';
import 'package:finance/src/data/response/transaction_response.dart';

abstract class TransactionRepository {
  /// Lấy danh sách giao dịch theo ngày/tuần/tháng (groupBy: 'day' | 'week' | 'month')
  Future<Either<AppException, List<TransactionResponse>>> getTransactions({
    String groupBy = 'day',
  });

  // /// Thêm một giao dịch mới
  // Future<void> addTransaction(Transaction transaction);
  //
  // /// Xóa giao dịch theo ID
  // Future<void> deleteTransaction(String id);
}
