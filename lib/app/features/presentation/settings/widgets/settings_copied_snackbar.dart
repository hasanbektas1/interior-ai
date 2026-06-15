import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class SettingsCopiedSnackBar {
  const SettingsCopiedSnackBar._();

  static void show(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          duration: Duration(seconds: 2),
          content: Center(child: _CopiedPill()),
        ),
      );
  }
}

class _CopiedPill extends StatelessWidget {
  const _CopiedPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width20,
        vertical: context.height20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.platinum),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000),
            blurRadius: context.width20,
            offset: Offset(0, context.height4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.width28,
            height: context.width28,
            decoration: const BoxDecoration(
              color: AppColors.smokyBlack,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: context.width20,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: context.width12),
          const Text(
            AppStrings.settingsCopiedToClipboard,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
