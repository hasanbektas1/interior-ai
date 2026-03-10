import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/onboarding/onboarding_models.dart';
import 'package:interior_ai/app/features/presentation/onboarding/widgets/selection_grid_item.dart';

class PickSpaceView extends StatelessWidget {
  const PickSpaceView({
    super.key,
    required this.selectedSpace,
    required this.onSelect,
  });

  final OnboardingSpace? selectedSpace;
  final ValueChanged<OnboardingSpace> onSelect;

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
                AppStrings.onboardingPickSpaceTitle,
                style: TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppStrings.onboardingPickSpaceSubtitle,
                style: TextStyle(
                  color: AppColors.nickel,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: OnboardingSpace.values.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final space = OnboardingSpace.values[index];
                return SelectionGridItem(
                  label: space.label,
                  imagePath: space.selectAsset,
                  isSelected: selectedSpace == space,
                  onTap: () => onSelect(space),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
