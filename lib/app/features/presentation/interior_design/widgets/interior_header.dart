import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/step_progress_bar.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class InteriorHeader extends StatelessWidget {
  const InteriorHeader({
    super.key,
    required this.filledCount,
    required this.onClose,
    this.onBack,
  });

  final int filledCount;
  final VoidCallback onClose;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onBack != null) ...[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBack,
                child: Icon(Icons.chevron_left, color: AppColors.richBlack),
              ),
            ],
            const Text(
              AppStrings.interiorDesign,
              style: TextStyle(
                color: AppColors.richBlack,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onClose,
              child: Icon(Icons.close_rounded, size: context.width24),
            ),
          ],
        ),
        SizedBox(height: context.height16),
        StepProgressBar(filledCount: filledCount),
      ],
    );
  }
}
