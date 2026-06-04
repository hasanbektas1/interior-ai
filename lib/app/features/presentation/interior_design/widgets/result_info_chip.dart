import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ResultInfoChip extends StatelessWidget {
  const ResultInfoChip({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final AppAsset? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cloudGray,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height12),
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.platinum),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  SvgPicture.asset(
                    icon!.path,
                    width: context.width20,
                    height: context.width20,
                  ),
                  SizedBox(width: context.width8),
                ],
                Flexible(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.smokyBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
