import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class CreditPackTile extends StatelessWidget {
  const CreditPackTile({super.key, required this.product, required this.onTap});

  final StoreProduct product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width16,
        vertical: context.height16,
      ),
      decoration: BoxDecoration(
        color: AppColors.cloudGray,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: context.width12),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.width20,
                vertical: context.height10,
              ),
              decoration: BoxDecoration(
                color: AppColors.hanPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${AppStrings.creditsBuyAction} ${product.priceString}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
