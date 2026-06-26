import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/domain/repositories/user_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class GetCurrentUserUseCase extends UseCase<UserEntity, GetCurrentUserParams> {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<AppException, UserEntity>> call(GetCurrentUserParams params) {
    return _repository.getCurrentUser(
      params.taxIdOrId,
      params.username,
    );
  }
}

class GetCurrentUserParams {
  final String taxIdOrId;
  final String username;

  GetCurrentUserParams({
    required this.taxIdOrId,
    required this.username,
  });
}
