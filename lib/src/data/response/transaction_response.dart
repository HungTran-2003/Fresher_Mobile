import 'package:json_annotation/json_annotation.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse {
  @JsonKey()
  final int id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'wallet_id')
  final int walletId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'icon_key')
  final String? iconKey;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey()
  final double amount;
  @JsonKey()
  final String type;
  @JsonKey()
  final DateTime date;
  @JsonKey()
  final String? note;

  const TransactionResponse(
    this.id,
    this.userId,
    this.walletId,
    this.categoryId,
    this.iconKey,
    this.categoryName,
    this.amount,
    this.type,
    this.date,
    this.note,
  );

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}
