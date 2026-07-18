import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum CreditsStatus { initial, loading, ready, error }

final class CreditsState extends Equatable {
  const CreditsState({
    this.status = CreditsStatus.initial,
    this.balance = 0,
    this.products = const [],
    this.purchasing = false,
  });

  final CreditsStatus status;
  final int balance;
  final List<StoreProduct> products;

  /// True while a purchase is in flight (blocks duplicate taps).
  final bool purchasing;

  CreditsState copyWith({
    CreditsStatus? status,
    int? balance,
    List<StoreProduct>? products,
    bool? purchasing,
  }) {
    return CreditsState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      products: products ?? this.products,
      purchasing: purchasing ?? this.purchasing,
    );
  }

  @override
  List<Object?> get props => [status, balance, products, purchasing];
}
