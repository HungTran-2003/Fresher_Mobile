import 'dart:io';

abstract class UploadRepository {
  /// Uploads an image file and returns the secure URL.
  Future<String?> uploadImage(File file);

  /// Gets an optimized URL for the given image.
  String getOptimizedUrl(String? imageUrl, {int width, int height});
}
