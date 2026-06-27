import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ProductModel {
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
  @HiveField(5)
  final String code;
  @HiveField(6)
  final double price;
  @HiveField(7)
  final int stock;
  @HiveField(8)
  final CategoryModel? category;
  @HiveField(9)
  final String? description;
  @HiveField(10)
  final String? image;

  ProductModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.code,
    required this.price,
    required this.stock,
    this.category,
    this.description,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(
    id: id,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
    name: name,
    code: code,
    price: price,
    stock: stock,
    category: category?.toEntity(),
    description: description,
    image: image,
  );
}
