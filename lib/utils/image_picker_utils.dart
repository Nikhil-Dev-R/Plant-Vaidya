import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'dart:io' show Platform;

class ImagePickerUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickImage(ImageSource source) async {
    // Web platform doesn't support picking from camera directly in all browsers or without specific setup
    // and desktop support for camera via image_picker is limited.
    // For simplicity, forcing gallery for web/desktop if camera is chosen.
    ImageSource effectiveSource = source;
    if ((kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) && source == ImageSource.camera) {
      effectiveSource = ImageSource.gallery;
      // Optionally, show a message to the user explaining this.
    }

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: effectiveSource,
        maxWidth: 1800, // Optional: constrain image size
        maxHeight: 1800,
        imageQuality: 80, // Optional: compress image
      );
      return pickedFile;
    } catch (e) {
      // Handle exceptions, e.g., permission denied
      debugPrint('Error picking image: $e');
      return null;
    }
  }
}
