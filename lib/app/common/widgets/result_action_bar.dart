import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ResultActionBar extends StatelessWidget {
  const ResultActionBar({
    super.key,
    required this.onDelete,
    required this.onRegenerate,
    required this.onSave,
  });

  final VoidCallback onDelete;
  final VoidCallback onRegenerate;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionIconButton(asset: AppAsset.interiorIconDelete, onTap: onDelete),
        SizedBox(width: context.width32),
        _ActionIconButton(
          asset: AppAsset.interiorIconLoop,
          onTap: onRegenerate,
        ),
        SizedBox(width: context.width32),
        Expanded(
          child: AppButton.fill(
            text: AppStrings.interiorSaveButton,
            onPressed: onSave,
            backgroundColor: AppColors.hanPurple,
            borderRadius: 12,
            height: 52,
          ),
        ),
      ],
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  const _ActionIconButton({required this.asset, required this.onTap});

  final AppAsset asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: context.width52,
        height: context.width52,
        decoration: BoxDecoration(
          color: AppColors.cloudGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            asset.path,
            width: context.width24,
            height: context.width24,
            colorFilter: const ColorFilter.mode(
              AppColors.smokyBlack,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
