import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:crud_app/configs/app_config.dart';
import 'dio_interceptor.dart';

class NetworkUtil {
  NetworkUtil._();

  static late final Dio dio;

  /// Initialize the global Dio instance with base URL, timeouts, and interceptors.
  static void init({
    String baseUrl = AppConfigs.baseUrl,
    Duration? timeout,
    List<Interceptor>? additionalInterceptors,
  }) {
    final timeoutDuration = timeout ?? AppConfigs.timeOutDuration;

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeoutDuration,
        receiveTimeout: timeoutDuration,
        sendTimeout: timeoutDuration,
      ),
    );

    // Add custom interceptor for authentication and headers
    dio.interceptors.add(CustomDioInterceptor());

    // Add logger for request/response debugging
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    // Add any other additional interceptors
    if (additionalInterceptors != null) {
      dio.interceptors.addAll(additionalInterceptors);
    }
  }

  /// Checks if the device has an active internet connection.
  static Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
