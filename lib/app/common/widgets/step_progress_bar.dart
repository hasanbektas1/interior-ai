import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class StepProgressBar extends StatelessWidget {
  const StepProgressBar({
    super.key,
    required this.filledCount,
    this.count = 4,
  });

  final int filledCount;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (index) {
        final bool isFilled = index < filledCount;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: context.height6,
            margin: EdgeInsets.symmetric(horizontal: context.width4),
            decoration: BoxDecoration(
              color: isFilled ? AppColors.softPurple : AppColors.platinum,
              borderRadius: BorderRadius.circular(context.width8),
            ),
          ),
        );
      }),
    );
  }
}
