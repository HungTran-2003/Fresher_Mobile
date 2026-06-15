import 'package:hive_ce/hive.dart';

part 'account_model.g.dart';

@HiveType(typeId: 0)
class AccountModel extends HiveObject {
  @HiveField(0)
  final String taxIdOrId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String passwordHash;

  @HiveField(3)
  final String salt;

  @HiveField(4)
  final String fullName;

  @HiveField(5)
  final bool enabled;

  @HiveField(6)
  final int updatedAt;

  AccountModel({
    required this.taxIdOrId,
    required this.username,
    required this.passwordHash,
    required this.salt,
    required this.fullName,
    required this.enabled,
    required this.updatedAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      taxIdOrId: json['taxIdOrId'] as String,
      username: json['username'] as String,
      passwordHash: json['passwordHash'] as String,
      salt: json['salt'] as String,
      fullName: json['fullName'] as String,
      enabled: json['enabled'] as bool? ?? true,
      updatedAt: (json['updatedAt'] is num)
          ? (json['updatedAt'] as num).toInt()
          : int.parse(json['updatedAt'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taxIdOrId': taxIdOrId,
      'username': username,
      'passwordHash': passwordHash,
      'salt': salt,
      'fullName': fullName,
      'enabled': enabled,
      'updatedAt': updatedAt,
    };
  }
}
