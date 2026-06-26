import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class GetCategoriesUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final ProductRepository _repository;

  GetCategoriesUseCase(this._repository);

  @override
  Future<Either<AppException, List<CategoryEntity>>> call(NoParams params) {
    return _repository.getCategories();
  }
}
