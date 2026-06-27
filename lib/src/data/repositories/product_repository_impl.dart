import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/models/product/product_model.dart';
import 'package:crud_app/src/data/services/hive/product/hive_product_service.dart';
import 'package:crud_app/src/data/services/network/dio_client.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DioClient _dioClient;
  final HiveProductService _hiveService;

  ProductRepositoryImpl({
    required DioClient dioClient,
    required HiveProductService hiveService,
  }) : _dioClient = dioClient,
       _hiveService = hiveService;

  @override
  Future<Either<AppException, List<ProductEntity>>> getRemoteProducts({
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

      final remoteProducts = response.data;
      final localProducts = await _hiveService.getProducts();

      // Sync logic: Only update if updatedAt is different or new
      final List<ProductModel> toUpdate = [];
      for (var remote in remoteProducts) {
        final local = localProducts.firstWhere(
          (l) => l.id == remote.id,
          orElse: () => ProductModel(
            id: -1,
            status: 0,
            createdAt: '',
            updatedAt: '',
            name: '',
            code: '',
            price: 0,
            stock: 0,
          ),
        );

        if (local.id == -1 || local.updatedAt != remote.updatedAt) {
          toUpdate.add(remote);
        }
      }

      if (toUpdate.isNotEmpty) {
        await _hiveService.saveProducts(toUpdate);
      }

      return Either.right(_mapModelsToEntities(remoteProducts));
    } catch (e) {
      // Always return the error for remote fetching
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, List<ProductEntity>>> getLocalProducts({
    String? search,
    int? categoryId,
  }) async {
    try {
      final localProducts = await _hiveService.getProducts();
      
      var filtered = localProducts;
      if (search != null && search.isNotEmpty) {
        filtered = filtered.where((p) => p.name.toLowerCase().contains(search.toLowerCase())).toList();
      }
      if (categoryId != null) {
        filtered = filtered.where((p) => p.category?.id == categoryId).toList();
      }

      return Either.right(_mapModelsToEntities(filtered));
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  List<ProductEntity> _mapModelsToEntities(List<ProductModel> models) {
    final List<ProductEntity> entities = [];
    for (var model in models) {
      try {
        entities.add(model.toEntity());
      } catch (e) {
        // Gracefully skip items that fail to map
        debugPrint('ProductRepository: Failed to map product ${model.id}: $e');
      }
    }
    return entities;
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
        'category_id': categoryId,
        'status': status,
        'tags': tags,
        'description': description,
        'image': image,
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
