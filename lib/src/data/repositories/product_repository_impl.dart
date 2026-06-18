import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/models/product/category_model.dart';
import 'package:crud_app/src/data/models/product/products_response.dart';
import 'package:crud_app/src/data/services/network/dio_client.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:dart_either/dart_either.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DioClient _dioClient;

  ProductRepositoryImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either<AppException, ProductsResponse>> getProducts({
    required int page,
    required int limit,
    String? search,
    int? categoryId,
  }) async {
    try {
      final response = await _dioClient.getProducts(
        page: page,
        limit: limit,
        search: search,
        categoryId: categoryId,
      );
      return Either.right(response);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _dioClient.getCategories();
      return Either.right(response.data);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }
}
