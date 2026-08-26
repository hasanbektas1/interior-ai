import 'package:interior_ai/core/logger/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens external web links (e.g. the privacy policy and terms pages) in the
/// device browser.
abstract final class AppLinkLauncher {
  static Future<void> open(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e, s) {
      AppLogger.instance.error(
        'AppLinkLauncher open failed: $url',
        error: e,
        stackTrace: s,
      );
    }
  }
}
