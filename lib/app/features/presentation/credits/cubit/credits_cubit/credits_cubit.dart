import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/config/revenuecat_config.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_state.dart';
import 'package:interior_ai/core/helpers/purchase_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Reads the credit packs and the per-user balance from RevenueCat
/// (`getVirtualCurrencies`). Spending happens server-side (backend → RC REST
/// API), so this cubit only reads and buys.
final class CreditsCubit extends Cubit<CreditsState> {
  CreditsCubit() : super(const CreditsState()) {
    load();
  }

  Future<void> load() async {
    if (!RevenueCatConfig.isConfigured) {
      emit(state.copyWith(status: CreditsStatus.error));
      return;
    }
    emit(state.copyWith(status: CreditsStatus.loading));
    try {
      final products = await PurchaseService.creditProducts()
        ..sort((a, b) => a.price.compareTo(b.price));
      final balance = await PurchaseService.creditBalance();
      emit(
        state.copyWith(
          status: CreditsStatus.ready,
          products: products,
          balance: balance,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CreditsStatus.error));
    }
  }

  /// Buys a credit pack; RevenueCat grants the currency and we re-read the
  /// balance from RevenueCat afterwards.
  Future<bool> buy(StoreProduct product) async {
    if (state.purchasing) return false;
    emit(state.copyWith(purchasing: true));
    try {
      await PurchaseService.buy(product);
      final balance = await PurchaseService.creditBalance(refresh: true);
      emit(state.copyWith(purchasing: false, balance: balance));
      return true;
    } catch (_) {
      emit(state.copyWith(purchasing: false));
      return false;
    }
  }

  /// Re-reads the balance from RevenueCat (e.g. after a backend deduction).
  Future<void> refresh() async {
    if (!RevenueCatConfig.isConfigured) return;
    try {
      final balance = await PurchaseService.creditBalance(refresh: true);
      emit(state.copyWith(balance: balance));
    } catch (_) {}
  }

  /// Restores purchases via RevenueCat and re-reads the balance. Returns whether
  /// the operation completed without error (used to show user feedback).
  Future<bool> restore() async {
    if (!RevenueCatConfig.isConfigured) return false;
    try {
      await PurchaseService.restore();
      final balance = await PurchaseService.creditBalance(refresh: true);
      emit(state.copyWith(balance: balance));
      return true;
    } catch (_) {
      return false;
    }
  }
}
