import 'package:dart_either/dart_either.dart';

extension EitherExtension<L, R> on Either<L, R> {
  C foldResult<C>({
    required C Function(L failure) onError,
    required C Function(R value) onSuccess,
  }) {
    return fold(
      ifLeft: (failure) => onError(failure),
      ifRight: (value) => onSuccess(value),
    );
  }
}
