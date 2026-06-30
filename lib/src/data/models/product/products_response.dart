import 'package:json_annotation/json_annotation.dart';
import 'product_model.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(defaultValue: [])
  final List<ProductModel> data;

  ProductsResponse({required this.data});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
