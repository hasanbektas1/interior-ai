import 'package:flutter/services.dart' show rootBundle;
import 'package:gal/gal.dart';

/// Saves an image to the device photo gallery. Handles both bundled asset
/// paths (`assets/...`) and device file paths.
final class GallerySaverService {
  Future<void> save(String imagePath) async {
    if (imagePath.startsWith('assets/')) {
      final data = await rootBundle.load(imagePath);
      await Gal.putImageBytes(data.buffer.asUint8List());
      return;
    }
    await Gal.putImage(imagePath);
  }
}
