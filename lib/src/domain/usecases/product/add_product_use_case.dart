import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class AddProductUseCase extends UseCase<void, AddProductParams> {
  final ProductRepository _repository;

  AddProductUseCase(this._repository);

  @override
  Future<Either<AppException, void>> call(AddProductParams params) {
    return _repository.addProduct(
      name: params.name,
      code: params.code,
      price: params.price,
      stock: params.stock,
      categoryId: params.categoryId,
      tags: params.tags,
      status: params.status,
      description: params.description,
      image: params.image,
    );
  }
}

class AddProductParams {
  final String name;
  final String code;
  final double price;
  final int stock;
  final int? categoryId;
  final List<String>? tags;
  final int? status;
  final String? description;
  final String? image;

  AddProductParams({
    required this.name,
    required this.code,
    required this.price,
    required this.stock,
    this.categoryId,
    this.tags,
    this.status,
    this.description,
    this.image,
  });
}
