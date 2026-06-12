import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.ghostWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.width20),
          topRight: Radius.circular(context.width20),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000),
            blurRadius: context.width20,
            offset: Offset(0, -context.height4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.height12,
            horizontal: context.width24,
          ),
          child: Row(
            children: [
              _NavItem(
                label: AppStrings.navHome,
                activeIcon: AppAsset.navHomeActive,
                inactiveIcon: AppAsset.navHomeInactive,
                isSelected: currentIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              _NavItem(
                label: AppStrings.navCollection,
                activeIcon: AppAsset.navCollectionActive,
                inactiveIcon: AppAsset.navCollectionInactive,
                isSelected: currentIndex == 1,
                onTap: () => onTabSelected(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final AppAsset activeIcon;
  final AppAsset inactiveIcon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              (isSelected ? activeIcon : inactiveIcon).path,
              width: context.width24,
              height: context.height24,
            ),
            SizedBox(height: context.height4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.homeNavBarText : AppColors.nickel,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
