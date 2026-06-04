import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class CollectionEmpty extends StatelessWidget {
  const CollectionEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.architecture_rounded,
            size: context.width48,
            color: AppColors.spanishGray,
          ),
          SizedBox(height: context.height16),
          const Text(
            AppStrings.collectionEmptyTitle,
            style: TextStyle(
              color: AppColors.nickel,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.height4),
          const Text(
            AppStrings.collectionEmptySubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.nickel,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
