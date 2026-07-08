import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Opens the native share sheet. Centralised so every entry point (settings,
/// collection, result screens) behaves identically and also works on iPad,
/// where the sheet must be anchored to a source rect.
class AppShare {
  const AppShare._();

  /// Shares the app itself (promo text).
  static Future<void> app(BuildContext context) async {
    await Share.share(
      AppStrings.settingsShareMessage,
      sharePositionOrigin: _anchor(context),
    );
  }

  /// Shares a produced design image together with the promo text. [imagePath]
  /// may be a bundled asset (`assets/...`) or a device file path; assets are
  /// copied to a temporary file first so they can be shared as an image. Falls
  /// back to a text-only share when the image cannot be resolved.
  static Future<void> image(BuildContext context, String imagePath) async {
    final anchor = _anchor(context);
    final file = await _resolveFile(imagePath);
    if (file == null) {
      await Share.share(
        AppStrings.settingsShareMessage,
        sharePositionOrigin: anchor,
      );
      return;
    }
    await Share.shareXFiles(
      [XFile(file.path)],
      text: AppStrings.settingsShareMessage,
      sharePositionOrigin: anchor,
    );
  }

  static Future<File?> _resolveFile(String path) async {
    if (path.isEmpty) return null;
    if (!path.startsWith('assets/')) {
      final file = File(path);
      return file.existsSync() ? file : null;
    }
    try {
      final data = await rootBundle.load(path);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${path.split('/').last}');
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
      return file;
    } catch (_) {
      return null;
    }
  }

  static Rect? _anchor(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }
}
