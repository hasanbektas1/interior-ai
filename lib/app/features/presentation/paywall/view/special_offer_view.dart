import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_accent_badge.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_background.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_close_button.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_footer.dart';
import 'package:interior_ai/app/features/presentation/paywall/widgets/paywall_plan_card.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class SpecialOfferView extends StatefulWidget {
  const SpecialOfferView({super.key});

  @override
  State<SpecialOfferView> createState() => _SpecialOfferViewState();
}

class _SpecialOfferViewState extends State<SpecialOfferView> {
  static const int _initialSeconds = 59;
  late int _secondsLeft = _initialSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer timer) {
    if (_secondsLeft <= 1) {
      timer.cancel();
      setState(() => _secondsLeft = 0);
      return;
    }
    setState(() => _secondsLeft -= 1);
  }

  String get _formattedTime {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: Stack(
        children: [
          const PaywallBackground(heightFactor: 0.5),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: PaywallCloseButton(
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ).symmetricPadding(horizontal: context.width16),
                const Spacer(flex: 2),
                PaywallAccentBadge(
                  text: _formattedTime,
                  fontSize: 24,
                  radius: 14,
                ),
                SizedBox(height: context.height24),
                const Text(
                  AppStrings.specialOfferTitle,
                  style: TextStyle(
                    color: AppColors.smokyBlack,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: context.height24),
                const PaywallAccentBadge(
                  text: AppStrings.specialOfferDiscount,
                  fontSize: 40,
                  radius: 20,
                ),
                const Spacer(flex: 3),
                Column(
                  children: [
                    PaywallPlanCard(
                      title: AppStrings.paywallAnnualTitle,
                      subtitle: AppStrings.paywallAnnualPerWeek,
                      price: AppStrings.paywallAnnualPrice,
                      isSelected: true,
                      showBestPrice: true,
                      onTap: () {},
                    ),
                    SizedBox(height: context.height20),
                    AppButton.fill(
                      text: AppStrings.continueButton,
                      onPressed: () => Navigator.of(context).maybePop(),
                      borderRadius: 14,
                      height: 54,
                      backgroundColor: AppColors.softPurple,
                    ),
                    SizedBox(height: context.height16),
                    const PaywallFooter(),
                  ],
                ).symmetricPadding(horizontal: context.width24),
                SizedBox(height: context.height16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
