import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/gradient_progress_ring.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ProcessingView extends StatelessWidget {
  const ProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.ghostWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.onboardingProcessingTitle,
              style: TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.onboardingProcessingSubtitle,
              style: TextStyle(
                color: AppColors.nickel,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 64),
            Center(
              child: GradientProgressRing(
                size: context.width140,
                strokeWidth: 10,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                "Processing...",
                style: TextStyle(
                  color: AppColors.nickel,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
