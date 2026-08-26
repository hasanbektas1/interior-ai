import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_state.dart';
import 'package:interior_ai/app/features/presentation/credits/widgets/credit_pack_tile.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/widgets/snackbar/app_snackbar.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class BuyCreditsSheet extends StatelessWidget {
  const BuyCreditsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<CreditsCubit>(),
        child: const BuyCreditsSheet(),
      ),
    );
  }

  Future<void> _onBuy(BuildContext context, StoreProduct product) async {
    final navigator = Navigator.of(context);
    final outcome = await context.read<CreditsCubit>().buy(product);
    switch (outcome) {
      case PurchaseOutcome.success:
        AppSnackBar.show(AppStrings.purchaseSuccess);
        navigator.maybePop();
      case PurchaseOutcome.failed:
        AppSnackBar.show(AppStrings.purchaseFailed);
      case PurchaseOutcome.cancelled:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.width24,
          context.height20,
          context.width24,
          context.height24,
        ),
        child: BlocBuilder<CreditsCubit, CreditsState>(
          builder: (context, state) {
            final cubit = context.read<CreditsCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.creditsBuyTitle,
                  style: TextStyle(
                    color: AppColors.smokyBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: context.height4),
                Text(
                  '${AppStrings.creditsBalanceLabel}: '
                  '${state.balance} ${AppStrings.creditsUnit}',
                  style: const TextStyle(
                    color: AppColors.nickel,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: context.height20),
                if (state.status == CreditsStatus.loading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.status == CreditsStatus.error ||
                    state.products.isEmpty)
                  _Unavailable(onRetry: cubit.load)
                else
                  for (final product in state.products) ...[
                    CreditPackTile(
                      product: product,
                      onTap: () => _onBuy(context, product),
                    ),
                    SizedBox(height: context.height12),
                  ],
                if (state.purchasing)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Unavailable extends StatelessWidget {
  const _Unavailable({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.creditsUnavailable,
          style: TextStyle(
            color: AppColors.nickel,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: context.height12),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onRetry,
          child: const Text(
            AppStrings.creditsRetry,
            style: TextStyle(
              color: AppColors.hanPurple,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
