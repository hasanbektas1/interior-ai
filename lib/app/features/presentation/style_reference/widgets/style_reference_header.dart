import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/step_progress_bar.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class StyleReferenceHeader extends StatelessWidget {
  const StyleReferenceHeader({
    super.key,
    required this.filledCount,
    required this.onClose,
  });

  final int filledCount;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                AppStrings.styleReference,
                style: TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: context.width36,
                  height: context.width36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.width10),
                    gradient: const LinearGradient(
                      colors: [AppColors.gradientBlue, AppColors.gradientPurple],
                    ),
                  ),
                  child: Icon(
                    Icons.diamond_outlined,
                    size: context.width20,
                    color: AppColors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onClose,
                  child: Icon(
                    Icons.close_rounded,
                    size: context.width24,
                    color: AppColors.smokyBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height16),
        StepProgressBar(filledCount: filledCount, count: 2),
      ],
    );
  }
}
