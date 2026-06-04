import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/interior_progress_bar.dart';
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
        SizedBox(
          height: context.height44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                AppStrings.interiorDesign,
                style: TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (onBack != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onBack,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: context.width32,
                      color: AppColors.smokyBlack,
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
        SizedBox(height: context.height16),
        InteriorProgressBar(filledCount: filledCount),
      ],
    );
  }
}
