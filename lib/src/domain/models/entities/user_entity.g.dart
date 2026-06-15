// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  id: json['id'] as String,
  userName: json['user_name'] as String,
  email: json['email'] as String,
  avatarUrl: json['avatar_url'] as String?,
  phoneNumber: json['phone_number'] as String?,
  dateOfBirth: json['date_of_birth'] as String?,
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'phone_number': instance.phoneNumber,
      'date_of_birth': instance.dateOfBirth,
    };
