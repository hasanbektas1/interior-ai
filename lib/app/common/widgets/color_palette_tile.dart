import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ColorPaletteTile extends StatelessWidget {
  const ColorPaletteTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isDimmed,
    required this.onTap,
    this.imagePath,
    this.colors,
  }) : assert(imagePath != null || colors != null);

  final String label;
  final String? imagePath;
  final List<Color>? colors;
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
        opacity: isDimmed ? 0.7 : 1,
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
                  child: imagePath != null
                      ? Image.asset(
                          imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const ColoredBox(color: AppColors.magnolia),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (final color in colors!)
                              Expanded(child: ColoredBox(color: color)),
                          ],
                        ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: context.height44,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: context.width16),
                    color: AppColors.paletteScrim,
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
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
