import 'package:json_annotation/json_annotation.dart';

part 'categories.g.dart';

@JsonSerializable()
class Category {
  @JsonKey()
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey()
  final String name;
  @JsonKey(name: 'icon_key')
  final String? iconKey;

  const Category({
    required this.id,
    required this.userId,
    required this.name,
    this.iconKey,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
