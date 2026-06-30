import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class GetLocalProductsUseCase extends UseCase<List<ProductEntity>, GetLocalProductsParams> {
  final ProductRepository _repository;

  GetLocalProductsUseCase(this._repository);

  @override
  Future<Either<AppException, List<ProductEntity>>> call(GetLocalProductsParams params) {
    return _repository.getLocalProducts(
      page: params.page,
      limit: params.limit,
      search: params.search,
      categoryId: params.categoryId,
    );
  }
}

class GetLocalProductsParams {
  final int page;
  final int limit;
  final String? search;
  final int? categoryId;

  GetLocalProductsParams({
    required this.page,
    required this.limit,
    this.search,
    this.categoryId,
  });
}
