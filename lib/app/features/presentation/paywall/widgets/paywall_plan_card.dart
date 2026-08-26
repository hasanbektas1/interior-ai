import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class PaywallPlanCard extends StatelessWidget {
  const PaywallPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onTap,
    this.showBestPrice = false,
  });

  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showBestPrice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: context.width16,
              vertical: context.height16,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.softPurpleFaint
                  : AppColors.cloudGray,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? AppColors.softPurple : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.smokyBlack,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: context.height4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppColors.nickel,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.width12),
                Text(
                  price,
                  style: const TextStyle(
                    color: AppColors.smokyBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (showBestPrice)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width12,
                  vertical: context.height4,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.softPurple,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: const Text(
                  AppStrings.paywallBestPrice,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
