import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class GetProductsUseCase extends UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  @override
  Future<Either<AppException, List<ProductEntity>>> call(GetProductsParams params) {
    return _repository.getProducts(
      page: params.page,
      limit: params.limit,
      search: params.search,
      categoryId: params.categoryId,
    );
  }
}

class GetProductsParams {
  final int page;
  final int limit;
  final String? search;
  final int? categoryId;

  GetProductsParams({
    required this.page,
    required this.limit,
    this.search,
    this.categoryId,
  });
}
