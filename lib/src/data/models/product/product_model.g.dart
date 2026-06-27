// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: (fields[0] as num).toInt(),
      status: (fields[1] as num).toInt(),
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
      name: fields[4] as String,
      code: fields[5] as String,
      price: (fields[6] as num).toDouble(),
      stock: (fields[7] as num).toInt(),
      category: fields[8] as CategoryModel?,
      description: fields[9] as String?,
      image: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.code)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.stock)
      ..writeByte(8)
      ..write(obj.category)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  status: (json['status'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  price: (json['price'] as num).toDouble(),
  stock: (json['stock'] as num).toInt(),
  category: json['category'] == null
      ? null
      : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
  description: json['description'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'name': instance.name,
      'code': instance.code,
      'price': instance.price,
      'stock': instance.stock,
      'category': instance.category,
      'description': instance.description,
      'image': instance.image,
    };
