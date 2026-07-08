import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

/// Horizontal row of square result variants used on the Replace Object result
/// screen (and its collection detail). Pass [onSelect] to make it interactive;
/// leave it null for a read-only preview that simply highlights [selectedIndex].
class ResultVariantStrip extends StatelessWidget {
  const ResultVariantStrip({
    super.key,
    required this.variants,
    required this.selectedIndex,
    this.onSelect,
  });

  final List<AppAsset> variants;
  final int selectedIndex;
  final ValueChanged<int>? onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < variants.length; i++) ...[
          if (i != 0) SizedBox(width: context.width8),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onSelect == null ? null : () => onSelect!(i),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.width12),
                    border: Border.all(
                      color: i == selectedIndex
                          ? AppColors.softPurple
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.width10),
                    child: Image.asset(
                      variants[i].path,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: AppColors.magnolia),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
