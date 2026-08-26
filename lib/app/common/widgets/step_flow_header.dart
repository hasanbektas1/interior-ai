import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/widgets/step_progress_bar.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class StepFlowHeader extends StatelessWidget {
  const StepFlowHeader({
    super.key,
    required this.title,
    required this.onClose,
    this.filledCount,
    this.count = 4,
    this.onBack,
  });

  final String title;
  final int? filledCount;
  final VoidCallback onClose;
  final int count;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onBack != null)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBack,
                child: const Icon(
                  Icons.chevron_left,
                  color: AppColors.richBlack,
                ),
              ),
            Text(
              title,
              style: const TextStyle(
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
        if (filledCount != null) ...[
          SizedBox(height: context.height16),
          StepProgressBar(filledCount: filledCount!, count: count),
          // Persistent gap so scrolling content never touches the progress bar.
          SizedBox(height: context.height4),
        ],
      ],
    );
  }
}
