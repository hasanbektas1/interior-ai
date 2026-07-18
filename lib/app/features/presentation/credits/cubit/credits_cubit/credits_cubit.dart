import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/config/revenuecat_config.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_state.dart';
import 'package:interior_ai/core/helpers/purchase_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Reads the credit packs and the remaining balance from RevenueCat. The
/// balance comes straight from RevenueCat (`getVirtualCurrencies`) — no backend
/// or local storage — and every read is logged to the console.
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
      final balance = await PurchaseService.creditBalance();
      emit(state.copyWith(purchasing: false, balance: balance));
      return true;
    } catch (_) {
      emit(state.copyWith(purchasing: false));
      return false;
    }
  }

  Future<void> restore() async {
    if (!RevenueCatConfig.isConfigured) return;
    try {
      await PurchaseService.restore();
      final balance = await PurchaseService.creditBalance();
      emit(state.copyWith(balance: balance));
    } catch (_) {}
  }
}
