import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class CollectionFilterChips extends StatelessWidget {
  const CollectionFilterChips({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final CollectionCategory? selected;
  final ValueChanged<CollectionCategory?> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _Chip(
            label: AppStrings.collectionFilterAll,
            isSelected: selected == null,
            onTap: () => onSelect(null),
          ),
          for (final category in CollectionCategory.values) ...[
            SizedBox(width: context.width8),
            _Chip(
              label: category.label,
              isSelected: selected == category,
              onTap: () => onSelect(category),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: context.width16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.softPurpleFaint : AppColors.cloudGray,
          borderRadius: BorderRadius.circular(context.width8),
          border: Border.all(
            color: isSelected ? AppColors.softPurple : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.smokyBlack : AppColors.nickel,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
