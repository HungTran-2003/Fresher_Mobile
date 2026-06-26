import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class GetLastLoginUseCase extends UseCase<Map<String, String>, NoParams> {
  final AuthRepository _repository;

  GetLastLoginUseCase(this._repository);

  @override
  Future<Either<AppException, Map<String, String>>> call(NoParams params) {
    return _repository.getLastLogin();
  }
}
