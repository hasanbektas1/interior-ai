import 'package:flutter/services.dart' show rootBundle;
import 'package:gal/gal.dart';
import 'package:interior_ai/core/logger/app_logger.dart';

/// Saves an image to the device photo gallery. Handles both bundled asset
/// paths (`assets/...`) and device file paths. Returns whether the save
/// succeeded so callers can show accurate success/failure feedback (Gal throws
/// on denied permission or write failure).
final class GallerySaverService {
  Future<bool> save(String imagePath) async {
    try {
      if (imagePath.startsWith('assets/')) {
        final data = await rootBundle.load(imagePath);
        await Gal.putImageBytes(data.buffer.asUint8List());
      } else {
        await Gal.putImage(imagePath);
      }
      return true;
    } catch (e, s) {
      AppLogger.instance.error(
        'GallerySaverService save failed',
        error: e,
        stackTrace: s,
      );
      return false;
    }
  }
}
