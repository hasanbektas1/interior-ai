import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/gradient_progress_ring.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class GeneratedProcessingView extends StatelessWidget {
  const GeneratedProcessingView({
    super.key,
    required this.onBackToHome,
    this.onBack,
  });

  final VoidCallback onBackToHome;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width24),
          child: Column(
            children: [
              if (onBack != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onBack,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: context.width32,
                      color: AppColors.smokyBlack,
                    ),
                  ),
                ),
              const Spacer(),
              GradientProgressRing(size: context.width160, strokeWidth: 10),
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
                backgroundColor: AppColors.hanPurple,
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
