import 'package:hive_ce/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

part 'account_model.g.dart';

@HiveType(typeId: 0)
class AccountModel extends HiveObject {
  @HiveField(0)
  final List<String> taxIdOrIds;

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
  final DateTime updatedAt;

  AccountModel({
    required this.taxIdOrIds,
    required this.username,
    required this.passwordHash,
    required this.salt,
    required this.fullName,
    required this.enabled,
    required this.updatedAt,
  });

  /// Backward-compatible getter to avoid compilation errors elsewhere.
  String get taxIdOrId => taxIdOrIds.isNotEmpty ? taxIdOrIds.first : '';

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    List<String> ids = [];

    void addIds(dynamic value) {
      if (value is List) {
        for (final item in value) {
          if (item != null) ids.add(item.toString());
        }
      } else if (value is String) {
        final trimmed = value.trim();
        if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
          try {
            final parsed = jsonDecode(trimmed);
            if (parsed is List) {
              for (final item in parsed) {
                if (item != null) ids.add(item.toString());
              }
            }
          } catch (_) {
            ids.add(trimmed);
          }
        } else if (trimmed.contains(',')) {
          ids.addAll(trimmed.split(',').map((s) => s.trim()));
        } else if (trimmed.contains(';')) {
          ids.addAll(trimmed.split(';').map((s) => s.trim()));
        } else if (trimmed.isNotEmpty) {
          ids.add(trimmed);
        }
      }
    }

    addIds(json['taxIdOrIds']);
    addIds(json['taxIdOrId']);

    // Deduplicate and filter out empty strings
    ids = ids.map((e) => e.trim()).where((e) => e.isNotEmpty).toSet().toList();

    DateTime updatedTime;
    final rawUpdated = json['updatedAt'];
    if (rawUpdated is Timestamp) {
      updatedTime = rawUpdated.toDate();
    } else if (rawUpdated is int) {
      // Treat as milliseconds since epoch or seconds since epoch
      if (rawUpdated < 10000000000) {
        updatedTime = DateTime.fromMillisecondsSinceEpoch(rawUpdated * 1000);
      } else {
        updatedTime = DateTime.fromMillisecondsSinceEpoch(rawUpdated);
      }
    } else if (rawUpdated is String) {
      updatedTime = DateTime.tryParse(rawUpdated) ?? DateTime.now();
    } else {
      updatedTime = DateTime.now();
    }

    return AccountModel(
      taxIdOrIds: ids,
      username: json['username'] as String,
      passwordHash: json['passwordHash'] as String,
      salt: json['salt'] as String,
      fullName: json['fullName'] as String,
      enabled: json['enabled'] as bool? ?? true,
      updatedAt: updatedTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taxIdOrIds': taxIdOrIds,
      'username': username,
      'passwordHash': passwordHash,
      'salt': salt,
      'fullName': fullName,
      'enabled': enabled,
      'updatedAt': updatedAt,
    };
  }
}
