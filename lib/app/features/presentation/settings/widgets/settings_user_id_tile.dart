import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class SettingsUserIdTile extends StatelessWidget {
  const SettingsUserIdTile({
    super.key,
    required this.userId,
    required this.onCopy,
    this.isCopied = false,
  });

  final String userId;
  final VoidCallback onCopy;
  final bool isCopied;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            AppAsset.settingsIconUserId.path,
            width: context.width24,
            height: context.width24,
            colorFilter: const ColorFilter.mode(
              AppColors.smokyBlack,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: context.width12),
          const Text(
            AppStrings.settingsUserId,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: context.width12),
          Expanded(
            child: Text(
              userId,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.nickel,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: context.width8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onCopy,
            child: Icon(
              isCopied ? Icons.content_copy : Icons.content_copy_outlined,
              size: context.width24,
              color: AppColors.smokyBlack,
            ),
          ),
        ],
      ),
    );
  }
}
