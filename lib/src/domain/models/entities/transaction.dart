import 'package:finance/src/domain/models/enum/transaction_type.dart';

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final String categoryKeyIcon;
  final DateTime date;
  final String? note;

  const Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.categoryKeyIcon,
    required this.date,
    this.note,
  });

  Transaction copyWith({
    String? id,
    double? amount,
    TransactionType? type,
    String? categoryKeyIcon,
    DateTime? date,
    String? note,
    String? attachmentUrl,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryKeyIcon: categoryKeyIcon ?? this.categoryKeyIcon,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }
}
