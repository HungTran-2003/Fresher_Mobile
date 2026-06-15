import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:finance/src/core/utils/extensions/logger.dart';

class SupabaseLoggingClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final startTime = DateTime.now();

    // Log Request
    logger.i('Supabase Request: ${request.method} ${request.url}');

    final response = await _inner.send(request);
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMilliseconds;

    // Intercept stream to log response body
    final bytes = await response.stream.toBytes();
    final responseBody = utf8.decode(bytes);

    logger.d(
      'Supabase Response [${response.statusCode}] (${duration}ms): $responseBody',
    );

    // Re-create the streamed response since we consumed the stream
    return http.StreamedResponse(
      Stream.value(bytes),
      response.statusCode,
      contentLength: response.contentLength,
      request: request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }
}
