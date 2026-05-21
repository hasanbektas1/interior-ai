import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';

class CollectionPlaceholder extends StatelessWidget {
  const CollectionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        AppStrings.navCollection,
        style: TextStyle(
          color: AppColors.nickel,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
