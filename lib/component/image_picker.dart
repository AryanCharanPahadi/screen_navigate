import 'dart:io'; // For checking if the platform is mobile
import 'package:flutter/foundation.dart'; // For checking if the platform is web
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Picks multiple images from the gallery
  Future<List<XFile>> pickImagesFromGallery({
    int imageQuality = 50,
    double maxWidth = 800,
    double maxHeight = 600,
  }) async {
    try {
      if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
        // Supported platforms: Android, iOS, Web
        final List<XFile>? selectedImages = await _picker.pickMultiImage(
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );
        return selectedImages ?? [];
      } else {
        throw UnsupportedError(
            "Gallery image picking is not supported on this platform.");
      }
    } catch (e) {
      print("Error picking images from gallery: $e");
      return [];
    }
  }

  /// Picks a single image from the camera
  Future<XFile?> pickImageFromCamera({
    int imageQuality = 50,
    double maxWidth = 800,
    double maxHeight = 600,
  }) async {
    try {
      if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
        // Supported platforms: Android, iOS, Web
        final XFile? pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );
        return pickedImage;
      } else {
        throw UnsupportedError(
            "Camera image picking is not supported on this platform.");
      }
    } catch (e) {
      print("Error picking image from camera: $e");
      return null;
    }
  }
}
