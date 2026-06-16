import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class InteriorPromptSection extends StatelessWidget {
  const InteriorPromptSection({super.key, required this.prompt});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.interiorPrompt,
          style: TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.height10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.width16),
          decoration: BoxDecoration(
            color: AppColors.cloudGray,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            prompt,
            style: const TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
        ),
        SizedBox(height: context.height16),
      ],
    );
  }
}
