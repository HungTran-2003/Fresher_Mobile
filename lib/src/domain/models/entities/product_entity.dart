import 'package:equatable/equatable.dart';
import 'category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String code;
  final double price;
  final int stock;
  final CategoryEntity? category;
  final String? description;
  final String? image;

  const ProductEntity({
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

  @override
  List<Object?> get props => [
    id,
    status,
    createdAt,
    updatedAt,
    name,
    code,
    price,
    stock,
    category,
    description,
    image,
  ];
}
