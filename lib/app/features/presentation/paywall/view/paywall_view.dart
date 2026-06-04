import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/features/presentation/paywall/enums/paywall_plan.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/special_offer_view.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/free_trial_toggle.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_background.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_close_button.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_feature_row.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_footer.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_plan_card.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({super.key});

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  PaywallPlan _selectedPlan = PaywallPlan.annual;
  bool _freeTrialEnabled = true;

  void _selectPlan(PaywallPlan plan) {
    setState(() => _selectedPlan = plan);
  }

  void _onClose() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SpecialOfferView()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: PaywallCloseButton(onTap: _onClose),
                ).symmetricPadding(horizontal: context.width16),
                const Spacer(),
                _Content(
                  selectedPlan: _selectedPlan,
                  freeTrialEnabled: _freeTrialEnabled,
                  onSelectPlan: _selectPlan,
                  onFreeTrialChanged: (v) => setState(() => _freeTrialEnabled = v),
                  onContinue: () => Navigator.of(context).maybePop(),
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
    required this.selectedPlan,
    required this.freeTrialEnabled,
    required this.onSelectPlan,
    required this.onFreeTrialChanged,
    required this.onContinue,
  });

  final PaywallPlan selectedPlan;
  final bool freeTrialEnabled;
  final ValueChanged<PaywallPlan> onSelectPlan;
  final ValueChanged<bool> onFreeTrialChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
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
          icon: Icons.design_services_outlined,
          label: AppStrings.paywallFeatureUnlimited,
        ),
        SizedBox(height: context.height16),
        const PaywallFeatureRow(
          icon: Icons.bolt_outlined,
          label: AppStrings.paywallFeatureFaster,
        ),
        SizedBox(height: context.height16),
        const PaywallFeatureRow(
          icon: Icons.block_outlined,
          label: AppStrings.paywallFeatureAdFree,
        ),
        SizedBox(height: context.height28),
        PaywallPlanCard(
          title: AppStrings.paywallWeeklyTitle,
          subtitle: AppStrings.paywallAutoRenewable,
          price: AppStrings.paywallWeeklyPrice,
          isSelected: selectedPlan == PaywallPlan.weekly,
          onTap: () => onSelectPlan(PaywallPlan.weekly),
        ),
        SizedBox(height: context.height12),
        PaywallPlanCard(
          title: AppStrings.paywallAnnualTitle,
          subtitle: AppStrings.paywallAnnualPerWeek,
          price: AppStrings.paywallAnnualPrice,
          isSelected: selectedPlan == PaywallPlan.annual,
          showBestPrice: true,
          onTap: () => onSelectPlan(PaywallPlan.annual),
        ),
        SizedBox(height: context.height16),
        FreeTrialToggle(value: freeTrialEnabled, onChanged: onFreeTrialChanged),
        SizedBox(height: context.height20),
        AppButton.fill(
          text: AppStrings.continueButton,
          onPressed: onContinue,
          borderRadius: 14,
          height: 54,
          backgroundColor: AppColors.softPurple,
        ),
        SizedBox(height: context.height16),
        const PaywallFooter(),
      ],
    ).symmetricPadding(horizontal: context.width24);
  }
}
