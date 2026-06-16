import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ExamplePhotoList extends StatelessWidget {
  const ExamplePhotoList({
    super.key,
    required this.photos,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<AppAsset> photos;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: photos.length,
        separatorBuilder: (_, __) => SizedBox(width: context.width12),
        itemBuilder: (context, index) {
          final bool isSelected = selectedIndex == index;
          final bool isDimmed = selectedIndex != null && !isSelected;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelect(index),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isDimmed ? 0.5 : 1,
              child: Container(
                width: context.width96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.width12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.softPurple
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.width10),
                  child: Image.asset(
                    photos[index].path,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const ColoredBox(color: AppColors.magnolia),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
