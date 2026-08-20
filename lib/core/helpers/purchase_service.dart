import 'package:interior_ai/app/common/config/revenuecat_config.dart';
import 'package:interior_ai/core/logger/app_logger.dart' as applog;
import 'package:purchases_flutter/purchases_flutter.dart';

/// Thin wrapper around the RevenueCat SDK for the consumable credit packs.
/// Every operation is logged through [applog.AppLogger] with the `[RevenueCat]`
/// tag so the whole purchase flow is traceable.
class PurchaseService {
  const PurchaseService._();

  static const String _tag = '[RevenueCat]';

  static void _log(String message) => applog.AppLogger.instance.log('$_tag $message');

  /// Initialises the SDK. No-op until a real API key is set in
  /// [RevenueCatConfig], so startup never crashes on the placeholder key.
  static Future<void> configure() async {
    if (!RevenueCatConfig.isConfigured) {
      applog.AppLogger.instance.log(
        '$_tag configure skipped — placeholder API key.',
        level: applog.LogLevel.warning,
      );
      return;
    }
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(
      PurchasesConfiguration(RevenueCatConfig.iosApiKey),
    );
    _log('configured (currency=${RevenueCatConfig.creditsCurrencyCode}).');
  }

  /// The purchasable credit packs, in the order declared in config.
  static Future<List<StoreProduct>> creditProducts() async {
    _log('fetching products ${RevenueCatConfig.creditProductIds}');
    try {
      final products = await Purchases.getProducts(
        RevenueCatConfig.creditProductIds,
      );
      _log(
        'fetched ${products.length} product(s): '
        '${products.map((p) => '${p.identifier}=${p.priceString}').toList()}',
      );
      return products;
    } catch (e, s) {
      applog.AppLogger.instance.error(
        '$_tag getProducts failed',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  /// Buys a credit pack. RevenueCat grants the configured virtual currency
  /// server-side once the purchase completes.
  static Future<PurchaseResult> buy(StoreProduct product) async {
    _log('purchasing ${product.identifier} (${product.priceString})');
    try {
      final result = await Purchases.purchase(
        PurchaseParams.storeProduct(product),
      );
      _log('purchase success ${product.identifier}');
      return result;
    } catch (e, s) {
      applog.AppLogger.instance.error(
        '$_tag purchase failed ${product.identifier}',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  /// Current credit balance from the RevenueCat virtual currency. Pass
  /// [refresh] after a purchase to bypass the SDK's cached balance.
  static Future<int> creditBalance({bool refresh = false}) async {
    try {
      if (refresh) await Purchases.invalidateVirtualCurrenciesCache();
      final currencies = await Purchases.getVirtualCurrencies();
      final balance =
          currencies.all[RevenueCatConfig.creditsCurrencyCode]?.balance ?? 0;
      _log('balance ${RevenueCatConfig.creditsCurrencyCode}=$balance');
      return balance;
    } catch (e, s) {
      applog.AppLogger.instance.error(
        '$_tag getVirtualCurrencies failed',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  /// The RevenueCat app user id. The generation Worker uses this to spend the
  /// user's credit balance server-side.
  static Future<String> appUserId() => Purchases.appUserID;

  /// Restores previous purchases (App Store account level).
  static Future<CustomerInfo> restore() async {
    _log('restoring purchases…');
    try {
      final info = await Purchases.restorePurchases();
      _log('restore complete.');
      return info;
    } catch (e, s) {
      applog.AppLogger.instance.error(
        '$_tag restore failed',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
