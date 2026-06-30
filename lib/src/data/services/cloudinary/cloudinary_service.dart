import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CloudinaryService {
  CloudinaryService._();

  static const String _cloudName = 'dhx0jghrl';

  /// Transforms any image URL to a Cloudinary-optimized URL using the Fetch API.
  static String getOptimizedUrl(
    String? imageUrl, {
    int width = 120,
    int height = 120,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return 'https://placehold.co/${width}x$height/png?text=No+Image';
    }

    if (imageUrl.startsWith('https://res.cloudinary.com')) {
      return imageUrl;
    }

    final encodedUrl = Uri.encodeFull(imageUrl);
    return 'https://res.cloudinary.com/$_cloudName/image/fetch/c_fill,g_face,w_$width,h_$height,f_auto,q_auto/$encodedUrl';
  }

  /// Uploads an image file to Cloudinary.
  /// Returns the secure URL of the uploaded image, or null if failed.
  static Future<String?> uploadImage(
    File file, {
    String uploadPreset = 'ml_default',
  }) async {
    try {
      final dio = Dio();
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'upload_preset': uploadPreset,
      });

      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['secure_url'] as String?;
      }
    } on DioException catch (e) {
      debugPrint(
        'CloudinaryService: Upload failed: ${e.response?.data ?? e.message}',
      );
    } catch (e) {
      debugPrint('CloudinaryService: Unexpected error: $e');
    }
    return null;
  }
}
