import 'dart:io';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';

class UploadImageUseCase {
  final UploadRepository _repository;

  UploadImageUseCase(this._repository);

  Future<String?> call(File file) {
    return _repository.uploadImage(file);
  }
}
