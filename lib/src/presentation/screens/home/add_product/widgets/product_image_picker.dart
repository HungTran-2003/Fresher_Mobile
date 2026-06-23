import 'dart:io';

import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final ValueChanged<File?> onImageChanged;
  final VoidCallback onRemoveImage;

  const ProductImagePicker({
    super.key,
    this.imageFile,
    this.imageUrl,
    required this.onImageChanged,
    required this.onRemoveImage,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImageChanged(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageFile != null || (imageUrl != null && imageUrl!.isNotEmpty))
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        imageUrl!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 150),
                      ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton(
                  onPressed: onRemoveImage,
                  icon: const Icon(Icons.close, color: Colors.white),
                  style: IconButton.styleFrom(backgroundColor: Colors.black54),
                ),
              ),
            ],
          )
        else
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: context.colors.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colors.outline.withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_a_photo_outlined, size: 40),
                  const SizedBox(height: 8),
                  Text(context.s.pickImage, style: context.textThemes.des12Re),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
