import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

/// Shared top bar for every result screen: centered title with a close action
/// on the left and an optional share action on the right.
class ResultHeader extends StatelessWidget {
  const ResultHeader({
    super.key,
    required this.onClose,
    this.title = AppStrings.interiorResultHeader,
    this.onShare,
  });

  final VoidCallback onClose;
  final String title;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          if (onShare != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onShare,
                child: Icon(
                  Icons.ios_share_rounded,
                  size: context.width24,
                  color: AppColors.smokyBlack,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
