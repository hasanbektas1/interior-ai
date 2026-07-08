import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

/// "Prompt" label above a rounded box holding the prompt text.
///
/// The box grows with the text up to three lines; beyond that it stays fixed
/// at three lines tall and scrolls internally so the surrounding layout never
/// overflows.
class ResultPromptSection extends StatelessWidget {
  const ResultPromptSection({super.key, required this.prompt});

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
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: context.height56),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
          ),
        ),
      ],
    );
  }
}
