import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class DeleteProductUseCase extends UseCase<void, int> {
  final ProductRepository _repository;

  DeleteProductUseCase(this._repository);

  @override
  Future<Either<AppException, void>> call(int id) {
    return _repository.deleteProduct(id);
  }
}
