import 'package:finance/src/domain/models/entities/budget.dart';

abstract class BudgetRepository {
  /// Lấy danh sách các hạn mức ngân sách
  Future<List<Budget>> getBudgets();

  /// Thêm một ngân sách mới
  Future<void> addBudget(Budget budget);

  /// Cập nhật hạn mức hoặc số tiền đã chi cho ngân sách
  Future<void> updateBudget(Budget budget);
}
