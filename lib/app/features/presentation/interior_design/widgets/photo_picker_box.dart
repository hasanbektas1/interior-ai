import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class PhotoPickerBox extends StatelessWidget {
  const PhotoPickerBox({
    super.key,
    required this.photoPath,
    required this.onAdd,
    required this.onRemove,
  });

  final String? photoPath;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    if (photoPath == null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onAdd,
        child: Container(
          width: double.infinity,
          height: context.height280,
          decoration: BoxDecoration(
            color: AppColors.platinum,
            borderRadius: BorderRadius.circular(context.width16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                size: context.width40,
                color: AppColors.nickel,
              ),
              SizedBox(height: context.height10),
              const Text(
                AppStrings.interiorAddYourPhoto,
                style: TextStyle(
                  color: AppColors.nickel,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: context.height280,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.width16),
              child: Image.asset(
                photoPath!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const ColoredBox(color: AppColors.magnolia),
              ),
            ),
          ),
          Positioned(
            top: context.height12,
            right: context.width12,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onRemove,
              child: Container(
                width: context.width28,
                height: context.width28,
                decoration: BoxDecoration(
                  color: AppColors.smokyBlack.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: context.width20,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
