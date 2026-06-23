import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final String? errorKey;
  final dynamic originalError;

  AppException({
    this.message = 'Something went wrong',
    this.code,
    this.errorKey,
    this.originalError,
  });

  @override
  String toString() =>
      'AppException(message: $message, code: $code, errorKey: $errorKey)';
}

class NetworkException extends AppException {
  NetworkException({
    super.message,
    super.code,
    super.errorKey,
    super.originalError,
  });
}

class ServerException extends AppException {
  ServerException({
    super.message,
    super.code,
    super.errorKey,
    super.originalError,
  });
}

class UnauthenticatedException extends AppException {
  UnauthenticatedException({
    super.message,
    super.code,
    super.errorKey,
    super.originalError,
  });
}

class UnauthorizedException extends AppException {
  UnauthorizedException({
    super.message,
    super.code,
    super.errorKey,
    super.originalError,
  });
}

class RequestCancelledException extends AppException {
  RequestCancelledException({
    super.message,
    super.code,
    super.errorKey,
    super.originalError,
  });
}

class UnknownException extends AppException {
  UnknownException({
    super.message,
    super.code,
    super.errorKey,
    super.originalError,
  });
}

/// Mapper to convert various errors (like DioException) to [AppException]
class ExceptionMapper {
  static AppException map(dynamic error) {
    if (error is AppException) return error;

    if (error is DioException && error.error is AppException) {
      return error.error as AppException;
    }

    return UnknownException(message: error.toString(), originalError: error);
  }
}
