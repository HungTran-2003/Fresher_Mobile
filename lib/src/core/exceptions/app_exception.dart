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

    if (error is DioException) {
      if (error.error is AppException) {
        return error.error as AppException;
      }

      return switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout => NetworkException(
          message: 'Connection timeout',
          originalError: error,
        ),
        DioExceptionType.connectionError => NetworkException(
          message: 'No internet connection',
          originalError: error,
        ),
        DioExceptionType.badResponse => _handleBadResponse(error),
        DioExceptionType.cancel => RequestCancelledException(
          message: 'Request cancelled',
          originalError: error,
        ),
        _ => UnknownException(message: error.message ?? 'Unknown error', originalError: error),
      };
    }

    return UnknownException(message: error.toString(), originalError: error);
  }

  static AppException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.data?['message']?.toString();

    return switch (statusCode) {
      401 => UnauthenticatedException(
        message: message ?? 'Unauthenticated',
        originalError: error,
      ),
      403 => UnauthorizedException(
        message: message ?? 'Unauthorized',
        originalError: error,
      ),
      500 => ServerException(
        message: message ?? 'Internal server error',
        originalError: error,
      ),
      _ => ServerException(
        message: message ?? 'Server error: $statusCode',
        originalError: error,
      ),
    };
  }
}
