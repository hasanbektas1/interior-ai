import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class SettingsUserIdTile extends StatelessWidget {
  const SettingsUserIdTile({
    super.key,
    required this.userId,
    required this.onCopy,
  });

  final String userId;
  final VoidCallback onCopy;

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
          Icon(Icons.person, size: context.width24, color: AppColors.smokyBlack),
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
              Icons.copy_rounded,
              size: context.width24,
              color: AppColors.smokyBlack,
            ),
          ),
        ],
      ),
    );
  }
}
