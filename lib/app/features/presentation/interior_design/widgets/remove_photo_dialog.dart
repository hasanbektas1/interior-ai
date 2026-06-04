import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class RemovePhotoDialog extends StatelessWidget {
  const RemovePhotoDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const RemovePhotoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(horizontal: context.width40),
      child: Padding(
        padding: EdgeInsets.all(context.width20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.interiorRemovePhotoTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.height20),
            AppButton.fill(
              text: AppStrings.interiorRemove,
              onPressed: () => Navigator.of(context).pop(true),
              backgroundColor: AppColors.softPurple,
              borderRadius: 14,
              height: 52,
            ),
            SizedBox(height: context.height10),
            AppButton(
              text: AppStrings.interiorCancel,
              onPressed: () => Navigator.of(context).pop(false),
              backgroundColor: AppColors.white,
              textColor: AppColors.softPurple,
              hasBorder: true,
              borderRadius: 14,
              height: 52,
            ),
          ],
        ),
      ),
    );
  }
}
