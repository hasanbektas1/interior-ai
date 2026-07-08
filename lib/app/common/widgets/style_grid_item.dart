import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class StyleGridItem extends StatelessWidget {
  const StyleGridItem({
    super.key,
    required this.label,
    required this.isCustom,
    required this.isSelected,
    required this.isDimmed,
    required this.onTap,
    this.imageAsset,
  });

  final String label;
  final bool isCustom;
  final bool isSelected;
  final bool isDimmed;
  final VoidCallback onTap;
  final AppAsset? imageAsset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isDimmed ? 0.5 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            // Only the custom card keeps the faint purple fill; image cards
            // stay transparent so no border-like ring shows when unselected.
            color: isCustom ? AppColors.softPurpleFaint : null,
            borderRadius: BorderRadius.circular(context.width16),
            border: Border.all(
              color: isSelected ? AppColors.softPurple : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.width12),
            child: isCustom ? _buildCustom(context) : _buildImage(context),
          ),
        ),
      ),
    );
  }

  Widget _buildCustom(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.weekend_rounded,
          size: context.width48,
          color: AppColors.softPurple,
        ),
        SizedBox(height: context.height8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.height12),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imageAsset!.path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const ColoredBox(color: AppColors.magnolia),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width16,
                  vertical: context.height12,
                ),
                color: AppColors.paletteScrim,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
