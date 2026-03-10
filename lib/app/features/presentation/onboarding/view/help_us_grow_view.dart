import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';

class HelpUsGrowView extends StatelessWidget {
  const HelpUsGrowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                AppStrings.onboardingHelpUsGrowTitle,
                style: TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppStrings.onboardingHelpUsGrowSubtitle,
                style: TextStyle(
                  color: AppColors.nickel,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: Center(child: _StarIllustration()),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _StarIllustration extends StatelessWidget {
  const _StarIllustration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            color: AppColors.magnolia,
            shape: BoxShape.circle,
          ),
        ),
        const Icon(Icons.star_rounded, size: 120, color: AppColors.hanPurple),
        Positioned(
          top: 20,
          right: 20,
          child: Icon(
            Icons.star_rounded,
            size: 32,
            color: AppColors.mediumPurple.withOpacity(0.5),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: const Icon(Icons.star_rounded, size: 24, color: AppColors.lavender),
        ),
      ],
    );
  }
}
