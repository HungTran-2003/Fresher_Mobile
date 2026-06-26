import 'package:dart_either/dart_either.dart';
import 'package:crud_app/src/core/exceptions/app_exception.dart';

abstract class UseCase<T, Params> {
  Future<Either<AppException, T>> call(Params params);
}

class NoParams {}
