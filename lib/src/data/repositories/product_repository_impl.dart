import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/services/network/dio_client.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:dart_either/dart_either.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DioClient _dioClient;

  ProductRepositoryImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<Either<AppException, List<ProductEntity>>> getProducts({
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
      return Either.right(response.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await _dioClient.getCategories();
      return Either.right(response.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
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
  }) async {
    try {
      final body = {
        'name': name,
        'code': code,
        'price': price,
        'stock': stock,
        'category_id': categoryId,
        'tags': tags,
        'status': status,
        'description': description,
        'image': image,
      };
      await _dioClient.addProduct(body);
      return const Either.right(null);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
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
  }) async {
    try {
      final body = {
        'name': name,
        'code': code,
        'price': price,
        'stock': stock,
        'category_id': ?categoryId,
        'status': ?status,
        'tags': ?tags,
        'description': ?description,
        'image': ?image,
      };
      await _dioClient.updateProduct(id, body);
      return const Either.right(null);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, void>> deleteProduct(int id) async {
    try {
      await _dioClient.deleteProduct(id);
      return const Either.right(null);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }
}
