import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.showChevron = true,
  });

  final AppAsset icon;
  final String label;
  final VoidCallback onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.width16,
          vertical: context.height16,
        ),
        decoration: BoxDecoration(
          color: AppColors.cloudGray,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon.path,
              width: context.width24,
              height: context.width24,
              colorFilter: const ColorFilter.mode(
                AppColors.smokyBlack,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: context.width12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.smokyBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (showChevron)
              Icon(
                Icons.chevron_right_rounded,
                size: context.width24,
                color: AppColors.smokyBlack,
              ),
          ],
        ),
      ),
    );
  }
}
