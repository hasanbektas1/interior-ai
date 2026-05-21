import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/home/cubit/home_state.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final HomeTab selectedTab;
  final ValueChanged<HomeTab> onTabSelected;

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
            vertical: context.height10,
            horizontal: context.width24,
          ),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  label: AppStrings.navHome,
                  icon: Icons.pentagon_rounded,
                  isSelected: selectedTab == HomeTab.home,
                  onTap: () => onTabSelected(HomeTab.home),
                ),
              ),
              Expanded(
                child: _NavItem(
                  label: AppStrings.navCollection,
                  icon: Icons.inventory_2_rounded,
                  isSelected: selectedTab == HomeTab.collection,
                  onTap: () => onTabSelected(HomeTab.collection),
                ),
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
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.hanPurple : AppColors.nickel;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: context.width24),
          SizedBox(height: context.height4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.nickel,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ).copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
