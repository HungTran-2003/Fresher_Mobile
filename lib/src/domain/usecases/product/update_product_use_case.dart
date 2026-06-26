import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class UpdateProductUseCase extends UseCase<void, UpdateProductParams> {
  final ProductRepository _repository;

  UpdateProductUseCase(this._repository);

  @override
  Future<Either<AppException, void>> call(UpdateProductParams params) {
    return _repository.updateProduct(
      id: params.id,
      name: params.name,
      code: params.code,
      price: params.price,
      stock: params.stock,
      categoryId: params.categoryId,
      status: params.status,
      tags: params.tags,
      description: params.description,
      image: params.image,
    );
  }
}

class UpdateProductParams {
  final int id;
  final String name;
  final String code;
  final double price;
  final int stock;
  final int? categoryId;
  final int? status;
  final List<String>? tags;
  final String? description;
  final String? image;

  UpdateProductParams({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.stock,
    this.categoryId,
    this.status,
    this.tags,
    this.description,
    this.image,
  });
}
