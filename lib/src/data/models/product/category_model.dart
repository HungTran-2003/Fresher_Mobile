import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CategoryModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int status;
  @HiveField(2)
  @JsonKey(name: 'created_at')
  final String createdAt;
  @HiveField(3)
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @HiveField(4)
  final String name;

  CategoryModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
    name: name,
  );
}
