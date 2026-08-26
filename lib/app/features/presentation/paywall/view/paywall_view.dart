import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_links.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/helpers/app_link_launcher.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_state.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_background.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_close_button.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_feature_row.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_footer.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_plan_card.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';
import 'package:interior_ai/core/widgets/snackbar/app_snackbar.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({super.key});

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  String? _selectedId;

  void _select(String id) => setState(() => _selectedId = id);

  /// Resolves the selected pack, defaulting to the best-value one (highest
  /// price = most credits, since products are sorted ascending).
  StoreProduct _selected(List<StoreProduct> products) {
    return products.firstWhere(
      (p) => p.identifier == _selectedId,
      orElse: () => products.last,
    );
  }

  Future<void> _onContinue(StoreProduct product) async {
    final outcome = await context.read<CreditsCubit>().buy(product);
    if (!mounted) return;
    switch (outcome) {
      case PurchaseOutcome.success:
        AppSnackBar.show(AppStrings.purchaseSuccess);
        Navigator.of(context).maybePop();
      case PurchaseOutcome.failed:
        AppSnackBar.show(AppStrings.purchaseFailed);
      case PurchaseOutcome.cancelled:
        break;
    }
  }

  Future<void> _onRestore() async {
    final ok = await context.read<CreditsCubit>().restore();
    AppSnackBar.show(ok ? AppStrings.restoreDone : AppStrings.restoreFailed);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreditsCubit>();
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: Stack(
        children: [
          const PaywallBackground(),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: PaywallCloseButton(
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ).symmetricPadding(horizontal: context.width16),
                const Spacer(),
                BlocBuilder<CreditsCubit, CreditsState>(
                  builder: (context, state) => _Content(
                    state: state,
                    selectedId: state.products.isEmpty
                        ? null
                        : _selected(state.products).identifier,
                    onSelect: _select,
                    onContinue: _onContinue,
                    onRetry: cubit.load,
                    onRestore: _onRestore,
                  ),
                ),
                SizedBox(height: context.height16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.state,
    required this.selectedId,
    required this.onSelect,
    required this.onContinue,
    required this.onRetry,
    required this.onRestore,
  });

  final CreditsState state;
  final String? selectedId;
  final ValueChanged<String> onSelect;
  final ValueChanged<StoreProduct> onContinue;
  final VoidCallback onRetry;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    final products = state.products;
    final bool hasProducts = products.isNotEmpty;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.paywallTitle,
          style: TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        SizedBox(height: context.height24),
        const PaywallFeatureRow(
          icon: Icons.auto_awesome_outlined,
          label: AppStrings.paywallFeatureUnlimited,
        ),
        SizedBox(height: context.height16),
        const PaywallFeatureRow(
          icon: Icons.high_quality_outlined,
          label: AppStrings.paywallFeatureFaster,
        ),
        SizedBox(height: context.height16),
        const PaywallFeatureRow(
          icon: Icons.home_outlined,
          label: AppStrings.paywallFeatureAdFree,
        ),
        SizedBox(height: context.height28),
        if (state.status == CreditsStatus.loading)
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height24),
            child: const Center(child: CircularProgressIndicator()),
          )
        else if (!hasProducts)
          _Unavailable(onRetry: onRetry)
        else ...[
          for (int i = 0; i < products.length; i++) ...[
            if (i != 0) SizedBox(height: context.height12),
            PaywallPlanCard(
              title: products[i].title,
              subtitle: products[i].description,
              price: products[i].priceString,
              isSelected: products[i].identifier == selectedId,
              showBestPrice: i == products.length - 1,
              onTap: () => onSelect(products[i].identifier),
            ),
          ],
        ],
        SizedBox(height: context.height20),
        AppButton.fill(
          text: AppStrings.continueButton,
          onPressed: (!hasProducts || state.purchasing)
              ? null
              : () => onContinue(
                  products.firstWhere((p) => p.identifier == selectedId),
                ),
          borderRadius: 14,
          height: 54,
          backgroundColor: AppColors.hanPurple,
          disabledBackgroundColor: AppColors.disabledGray,
          disabledTextColor: AppColors.disabledText,
        ),
        SizedBox(height: context.height16),
        PaywallFooter(
          onTermsTap: () => AppLinkLauncher.open(AppLinks.termsOfUse),
          onPrivacyTap: () => AppLinkLauncher.open(AppLinks.privacyPolicy),
          onRestoreTap: onRestore,
        ),
      ],
    ).symmetricPadding(horizontal: context.width24);
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
