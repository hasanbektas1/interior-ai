import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class PaywallCloseButton extends StatelessWidget {
  const PaywallCloseButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: context.width40,
        height: context.height40,
        child: Icon(
          Icons.close_rounded,
          size: context.width24,
          color: AppColors.smokyBlack,
        ),
      ),
    );
  }
}
