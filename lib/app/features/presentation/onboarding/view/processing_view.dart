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
          children: [
            const SizedBox(height: 16),
            const Text(
              AppStrings.onboardingProcessingTitle,
              style: TextStyle(
                color: AppColors.richBlack,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.onboardingProcessingSubtitle,
              style: TextStyle(
                color: AppColors.richBlack,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GradientProgressRing(
                      size: context.width140,
                      strokeWidth: 10,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      AppStrings.onboardingProcessingLabel,
                      style: TextStyle(
                        color: AppColors.nickel,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
