// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      (json['id'] as num).toInt(),
      json['user_id'] as String,
      (json['wallet_id'] as num).toInt(),
      (json['category_id'] as num).toInt(),
      json['icon_key'] as String?,
      json['category_name'] as String,
      (json['amount'] as num).toDouble(),
      json['type'] as String,
      DateTime.parse(json['date'] as String),
      json['note'] as String?,
    );

Map<String, dynamic> _$TransactionResponseToJson(
  TransactionResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'wallet_id': instance.walletId,
  'category_id': instance.categoryId,
  'icon_key': instance.iconKey,
  'category_name': instance.categoryName,
  'amount': instance.amount,
  'type': instance.type,
  'date': instance.date.toIso8601String(),
  'note': instance.note,
};
