import 'package:image_picker/image_picker.dart';

/// Wraps [ImagePicker] so cubits can request a photo from the device camera or
/// gallery without depending on the plugin directly. Returns the picked file
/// path, or `null` when the user cancels.
final class MediaPickerService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickFromCamera() => _pick(ImageSource.camera);

  Future<String?> pickFromGallery() => _pick(ImageSource.gallery);

  Future<String?> _pick(ImageSource source) async {
    // Downscale before use: the AI only needs ~1536px, and full-resolution
    // camera photos would bloat the upload (base64 is +33%), memory, and
    // generation time.
    final file = await _picker.pickImage(
      source: source,
      maxWidth: 1536,
      maxHeight: 1536,
      imageQuality: 85,
    );
    return file?.path;
  }
}
