import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/onboarding/onboarding_models.dart';
import 'package:interior_ai/app/features/presentation/onboarding/widgets/selection_grid_item.dart';

class FindStyleView extends StatelessWidget {
  const FindStyleView({
    super.key,
    required this.selectedStyle,
    required this.onSelect,
  });

  final OnboardingStyle? selectedStyle;
  final ValueChanged<OnboardingStyle> onSelect;

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
                AppStrings.onboardingFindStyleTitle,
                style: TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppStrings.onboardingFindStyleSubtitle,
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
              itemCount: OnboardingStyle.values.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final style = OnboardingStyle.values[index];
                return SelectionGridItem(
                  label: style.label,
                  imagePath: style.selectAsset,
                  isSelected: selectedStyle == style,
                  onTap: () => onSelect(style),
                  showLabel: true,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
