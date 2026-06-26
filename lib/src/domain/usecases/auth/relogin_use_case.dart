import 'package:crud_app/src/domain/repositories/auth_repository.dart';

class ReloginUseCase {
  final AuthRepository _repository;

  ReloginUseCase(this._repository);

  Future<String> call() {
    return _repository.relogin();
  }
}
