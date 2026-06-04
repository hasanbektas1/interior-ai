import 'dart:ui';

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
          height: context.height104,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.width16),
            border: Border.all(
              color: isSelected ? AppColors.softPurple : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.width12),
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
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      height: context.height44,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: context.width16),
                      color: AppColors.paletteScrim,
                      child: Text(
                        palette.label,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
