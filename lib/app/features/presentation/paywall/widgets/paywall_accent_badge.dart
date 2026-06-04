import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class PaywallAccentBadge extends StatelessWidget {
  const PaywallAccentBadge({
    super.key,
    required this.text,
    required this.fontSize,
    required this.radius,
  });

  final String text;
  final double fontSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width32,
        vertical: context.height12,
      ),
      decoration: BoxDecoration(
        color: AppColors.softPurpleFaint,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.softPurple, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.smokyBlack,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
