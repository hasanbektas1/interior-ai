import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class InteriorProcessingView extends StatelessWidget {
  const InteriorProcessingView({super.key, required this.onBackToHome});

  final VoidCallback onBackToHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width24),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                width: context.width80,
                height: context.width80,
                child: const CircularProgressIndicator(
                  color: AppColors.softPurple,
                  strokeWidth: 4,
                ),
              ),
              SizedBox(height: context.height24),
              const Text(
                AppStrings.interiorProcessing,
                style: TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: context.height10),
              const Text(
                AppStrings.interiorProcessingSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.nickel,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              AppButton.fill(
                text: AppStrings.interiorBackToHome,
                onPressed: onBackToHome,
                backgroundColor: AppColors.softPurple,
                borderRadius: 14,
                height: 54,
              ),
              SizedBox(height: context.height16),
            ],
          ),
        ),
      ),
    );
  }
}
