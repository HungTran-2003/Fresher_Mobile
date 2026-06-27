import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class ProductRepository {
  Future<Either<AppException, List<ProductEntity>>> getRemoteProducts({
    required int page,
    required int limit,
    String? search,
    int? categoryId,
  });

  Future<Either<AppException, List<ProductEntity>>> getLocalProducts({
    String? search,
    int? categoryId,
  });

  Future<Either<AppException, List<CategoryEntity>>> getCategories();

  Future<Either<AppException, void>> addProduct({
    required String name,
    required String code,
    required double price,
    required int stock,
    int? categoryId,
    List<String>? tags,
    int? status,
    String? description,
    String? image,
  });

  Future<Either<AppException, void>> updateProduct({
    required int id,
    required String name,
    required String code,
    required double price,
    required int stock,
    int? categoryId,
    int? status,
    List<String>? tags,
    String? description,
    String? image,
  });

  Future<Either<AppException, void>> deleteProduct(int id);
}
