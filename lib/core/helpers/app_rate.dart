import 'package:in_app_review/in_app_review.dart';

/// Triggers the native OS in-app review prompt (StoreKit on iOS, In-App Review
/// on Android). Centralised so every "Rate Us" entry point behaves the same.
class AppRate {
  const AppRate._();

  static final InAppReview _inAppReview = InAppReview.instance;

  static Future<void> request() async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      }
    } catch (_) {
      // Review prompt unavailable (e.g. not installed from a store) — ignore.
    }
  }
}
