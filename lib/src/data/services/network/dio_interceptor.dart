import 'dart:io';
import 'package:dio/dio.dart';
import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';

class CustomDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Inject headers
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    // Fetch token from secure storage
    final token = await SecureStorageDataSource.instance.getSessionToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Standard response handling
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Intercept 401 globally
    if (err.response?.statusCode == 401) {
      // Clear token / sign out user when unauthenticated
      await SecureStorageDataSource.instance.clearSession();
    }

    // Map DioException to AppException
    final appException = _mapDioException(err);

    // Pass the mapped exception inside DioException.error
    final modifiedError = err.copyWith(error: appException);

    super.onError(modifiedError, handler);
  }

  AppException _mapDioException(DioException error) {
    String message = error.message ?? 'An unexpected network error occurred';
    String? code = error.response?.statusCode?.toString();

    // Try to extract server message if available in response data
    if (error.response?.data != null) {
      final data = error.response!.data;
      if (data is Map<String, dynamic>) {
        if (data.containsKey('message')) {
          message = data['message'].toString();
        } else if (data.containsKey('error')) {
          message = data['error'].toString();
        }
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timed out. Please check your internet connection.',
          code: code,
          originalError: error,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return UnauthenticatedException(
            message: message.isNotEmpty ? message : 'Session expired. Please log in again.',
            code: code,
            originalError: error,
          );
        } else if (statusCode == 403) {
          return UnauthorizedException(
            message: message.isNotEmpty ? message : 'Access denied. You do not have permission.',
            code: code,
            originalError: error,
          );
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException(
            message: 'Server error occurred. Please try again later.',
            code: code,
            originalError: error,
          );
        } else {
          return ServerException(
            message: message,
            code: code,
            originalError: error,
          );
        }

      case DioExceptionType.cancel:
        return RequestCancelledException(
          message: 'Request was cancelled.',
          code: code,
          originalError: error,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please connect to the internet and try again.',
          code: code,
          originalError: error,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Secure connection could not be established (invalid certificate).',
          code: code,
          originalError: error,
        );

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NetworkException(
            message: 'No internet connection. Please connect to the internet and try again.',
            code: code,
            originalError: error,
          );
        }
        return UnknownException(
          message: message,
          code: code,
          originalError: error,
        );
    }
  }
}
