import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';

class PaywallFooter extends StatelessWidget {
  const PaywallFooter({
    super.key,
    this.onTermsTap,
    this.onPrivacyTap,
    this.onRestoreTap,
  });

  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onRestoreTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _FooterLink(label: AppStrings.paywallTermsOfUse, onTap: onTermsTap),
        _FooterLink(label: AppStrings.paywallPrivacyPolicy, onTap: onPrivacyTap),
        _FooterLink(label: AppStrings.paywallRestorePurchase, onTap: onRestoreTap),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.nickel,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.nickel,
        ),
      ),
    );
  }
}
