import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/models/account/account_model.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';

class LoginUseCase extends UseCase<AccountModel, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<AppException, AccountModel>> call(LoginParams params) {
    return _repository.login(
      taxIdOrId: params.taxIdOrId,
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams {
  final String taxIdOrId;
  final String username;
  final String password;

  LoginParams({
    required this.taxIdOrId,
    required this.username,
    required this.password,
  });
}
