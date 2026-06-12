import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';

class DreamSpaceView extends StatelessWidget {
  const DreamSpaceView({super.key, required this.mainImage, this.miniImage});

  final String mainImage;
  final String? miniImage;

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
                AppStrings.onboardingDreamSpaceTitle,
                style: TextStyle(
                  color: AppColors.richBlack,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppStrings.onboardingDreamSpaceSubtitle,
                style: TextStyle(
                  color: AppColors.richBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 40,
                  right: 0,
                  top: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      mainImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.magnolia,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.home_outlined,
                            size: 64,
                            color: AppColors.mediumPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (miniImage != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    width: 110,
                    height: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(miniImage!, fit: BoxFit.cover),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
