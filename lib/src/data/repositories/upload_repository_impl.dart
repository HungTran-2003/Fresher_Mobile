import 'dart:io';
import 'package:crud_app/src/data/services/cloudinary/cloudinary_service.dart';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';

class UploadRepositoryImpl implements UploadRepository {
  @override
  Future<String?> uploadImage(File file) {
    return CloudinaryService.uploadImage(file);
  }

  @override
  String getOptimizedUrl(String? imageUrl, {int width = 120, int height = 120}) {
    return CloudinaryService.getOptimizedUrl(imageUrl, width: width, height: height);
  }
}
