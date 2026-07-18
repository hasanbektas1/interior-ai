/// RevenueCat configuration values.
///
/// Fill [iosApiKey] with the **public** iOS SDK key from
/// RevenueCat → Apps → Roomora AI (ios) → "Show key" (starts with `appl_`).
abstract final class RevenueCatConfig {
  /// Public iOS SDK key. Until this is replaced, [isConfigured] is false and
  /// the SDK is not initialised (so the app doesn't crash at startup).
  static const String iosApiKey = 'appl_LjmcEIPZlnTRngppxXElBGPMsiG';

  /// Virtual currency code that credit packs grant (single source of truth).
  static const String creditsCurrencyCode = 'CREDITS';

  /// Consumable credit-pack product identifiers (must match App Store Connect).
  static const String credit10ProductId = 'com.hasan.interiorai.credit_pack.10';
  static const String credit50ProductId = 'credits_50';

  static const List<String> creditProductIds = [
    credit10ProductId,
    credit50ProductId,
  ];

  static bool get isConfigured => !iosApiKey.contains('REPLACE_WITH');
}
