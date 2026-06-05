import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/widgets/step_progress_bar.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class GemHeader extends StatelessWidget {
  const GemHeader({
    super.key,
    required this.title,
    required this.onClose,
    this.onBack,
    this.progressFilledCount,
    this.progressCount = 2,
  });

  final String title;
  final VoidCallback onClose;
  final VoidCallback? onBack;
  final int? progressFilledCount;
  final int progressCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: onBack != null
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onBack,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          size: context.width32,
                          color: AppColors.smokyBlack,
                        ),
                      )
                    : Container(
                        width: context.width36,
                        height: context.width36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.width10),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.gradientBlue,
                              AppColors.gradientPurple,
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.diamond_outlined,
                          size: context.width20,
                          color: AppColors.white,
                        ),
                      ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onClose,
                  child: Icon(
                    Icons.close_rounded,
                    size: context.width24,
                    color: AppColors.smokyBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (progressFilledCount != null) ...[
          SizedBox(height: context.height16),
          StepProgressBar(
            filledCount: progressFilledCount!,
            count: progressCount,
          ),
        ],
      ],
    );
  }
}
