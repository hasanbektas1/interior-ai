import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/color_palette.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ColorPaletteTile extends StatelessWidget {
  const ColorPaletteTile({
    super.key,
    required this.palette,
    required this.isSelected,
    required this.isDimmed,
    required this.onTap,
  });

  final ColorPalette palette;
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
          width: double.infinity,
          height: context.height58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.width12),
            border: Border.all(
              color: isSelected ? AppColors.softPurple : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.width10),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final color in palette.colors)
                        Expanded(child: ColoredBox(color: color)),
                    ],
                  ),
                ),
                Positioned(
                  left: context.width16,
                  bottom: context.height8,
                  child: Text(
                    palette.label,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          color: AppColors.smokyBlack.withValues(alpha: 0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
