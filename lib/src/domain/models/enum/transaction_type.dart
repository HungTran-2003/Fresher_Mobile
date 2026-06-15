enum TransactionType {
  income,
  expense;

  static TransactionType? fromText(String? code) {
    switch (code) {
      case 'income':
        return TransactionType.income;
      case 'expense':
        return TransactionType.expense;
    }
    return null;
  }
}

extension TransactionTypeExt on TransactionType {
  String get text {
    switch (this) {
      case TransactionType.income:
        return 'income';
      case TransactionType.expense:
        return 'expense';
    }
  }
}
