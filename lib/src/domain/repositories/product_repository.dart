import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/models/product/category_model.dart';
import 'package:crud_app/src/data/models/product/products_response.dart';
import 'package:dart_either/dart_either.dart';

abstract class ProductRepository {
  Future<Either<AppException, ProductsResponse>> getProducts({
    required int page,
    required int limit,
    String? search,
    int? categoryId,
  });

  Future<Either<AppException, List<CategoryModel>>> getCategories();
}
