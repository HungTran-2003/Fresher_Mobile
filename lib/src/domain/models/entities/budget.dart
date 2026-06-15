class Budget {
  final String id;
  final String category;
  final double limitAmount;
  final double spentAmount;
  final DateTime startDate;
  final DateTime endDate;

  const Budget({
    required this.id,
    required this.category,
    required this.limitAmount,
    required this.spentAmount,
    required this.startDate,
    required this.endDate,
  });

  /// Tính phần trăm ngân sách đã chi tiêu (0.0 -> 1.0)
  double get percentageSpent {
    if (limitAmount <= 0) return 0.0;
    return (spentAmount / limitAmount).clamp(0.0, 1.0);
  }

  /// Tính số tiền còn lại có thể chi tiêu
  double get remainingAmount {
    final diff = limitAmount - spentAmount;
    return diff > 0 ? diff : 0.0;
  }

  /// Kiểm tra xem ngân sách đã vượt hạn mức chưa
  bool get isExceeded => spentAmount > limitAmount;

  Budget copyWith({
    String? id,
    String? category,
    double? limitAmount,
    double? spentAmount,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Budget(
      id: id ?? this.id,
      category: category ?? this.category,
      limitAmount: limitAmount ?? this.limitAmount,
      spentAmount: spentAmount ?? this.spentAmount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
