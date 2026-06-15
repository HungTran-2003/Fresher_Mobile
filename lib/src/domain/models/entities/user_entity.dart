import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey()
  final String id;
  @JsonKey(name: 'user_name')
  final String userName;
  @JsonKey()
  final String email;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  const UserEntity({
    required this.id,
    required this.userName,
    required this.email,
    this.avatarUrl,
    this.phoneNumber,
    this.dateOfBirth,
  });

  UserEntity copyWith({
    String? id,
    String? userName,
    String? email,
    String? avatarUrl,
    String? phoneNumber,
    String? dateOfBirth,
  }) {
    return UserEntity(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
