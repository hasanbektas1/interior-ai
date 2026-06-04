import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/design_style.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class StyleGridItem extends StatelessWidget {
  const StyleGridItem({
    super.key,
    required this.style,
    required this.isSelected,
    required this.isDimmed,
    required this.onTap,
  });

  final DesignStyle style;
  final bool isSelected;
  final bool isDimmed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isDimmed ? 0.4 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.softPurpleFaint,
            borderRadius: BorderRadius.circular(context.width16),
            border: Border.all(
              color: isSelected ? AppColors.softPurple : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.width12),
            child: style.isCustom ? _buildCustom(context) : _buildImage(context),
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
          style.label,
          style: const TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          style.previewImage.path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const ColoredBox(color: AppColors.magnolia),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.width12,
              vertical: context.height8,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.smokyBlack.withValues(alpha: 0.55),
                ],
              ),
            ),
            child: Text(
              style.label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
