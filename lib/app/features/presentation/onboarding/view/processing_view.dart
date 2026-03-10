import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';

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
          children: const [
            Text(
              AppStrings.onboardingProcessingTitle,
              style: TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppStrings.onboardingProcessingSubtitle,
              style: TextStyle(
                color: AppColors.nickel,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 64),
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  color: AppColors.hanPurple,
                  strokeWidth: 3,
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
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
