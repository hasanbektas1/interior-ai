import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class GeneratedErrorView extends StatelessWidget {
  const GeneratedErrorView({
    super.key,
    required this.onTryAgain,
    required this.onBackToHome,
  });

  final VoidCallback onTryAgain;
  final VoidCallback onBackToHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.smokyBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width24),
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.error_outline_rounded,
                size: context.width64,
                color: AppColors.white,
              ),
              SizedBox(height: context.height24),
              const Text(
                AppStrings.interiorErrorTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: context.height10),
              const Text(
                AppStrings.interiorErrorSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.spanishGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: context.height32),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTryAgain,
                child: Container(
                  width: double.infinity,
                  height: context.height52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [AppColors.azure, AppColors.softPurple],
                    ),
                  ),
                  child: const Text(
                    AppStrings.interiorTryAgain,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBackToHome,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height12),
                  child: Text(
                    AppStrings.interiorBackToHome,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.4),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.height16),
            ],
          ),
        ),
      ),
    );
  }
}
