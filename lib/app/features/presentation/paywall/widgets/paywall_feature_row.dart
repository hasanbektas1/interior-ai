import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class PaywallFeatureRow extends StatelessWidget {
  const PaywallFeatureRow({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: context.width24, color: AppColors.smokyBlack),
        SizedBox(width: context.width12),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
