import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

enum PhotoSource { camera, library }

class AddPhotoBottomSheet extends StatelessWidget {
  const AddPhotoBottomSheet({super.key});

  static Future<PhotoSource?> show(BuildContext context) {
    return showModalBottomSheet<PhotoSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddPhotoBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(context.width16),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width20,
                    vertical: context.height16,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        AppStrings.interiorAddPhotoTitle,
                        style: TextStyle(
                          color: AppColors.smokyBlack,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: context.height4),
                      const Text(
                        AppStrings.interiorAddPhotoSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.nickel,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.platinum),
                _SheetAction(
                  label: AppStrings.interiorTakePhoto,
                  color: AppColors.smokyBlack,
                  onTap: () => Navigator.of(context).pop(PhotoSource.camera),
                ),
                const Divider(height: 1, color: AppColors.platinum),
                _SheetAction(
                  label: AppStrings.interiorChooseFromLibrary,
                  color: AppColors.softPurple,
                  onTap: () => Navigator.of(context).pop(PhotoSource.library),
                ),
              ],
            ),
          ),
          SizedBox(height: context.height10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(context.width16),
            ),
            child: _SheetAction(
              label: AppStrings.interiorCancel,
              color: AppColors.azure,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ).symmetricPadding(horizontal: context.width10),
    );
  }
}

class _SheetAction extends StatelessWidget {
  const _SheetAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.height16),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
