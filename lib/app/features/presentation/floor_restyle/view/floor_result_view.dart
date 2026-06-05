import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/buttons/gradient_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_segment_chip.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';
import 'package:share_plus/share_plus.dart';

class FloorResultView extends StatelessWidget {
  const FloorResultView({
    super.key,
    required this.materialLabel,
    required this.customPrompt,
    required this.onClose,
    required this.onRegenerate,
  });

  final String materialLabel;
  final String? customPrompt;
  final VoidCallback onClose;
  final VoidCallback onRegenerate;

  Future<void> _onSave(BuildContext context) async {
    await ResultActionDialog.show(
      context,
      title: AppStrings.interiorImageSavedTitle,
      subtitle: AppStrings.interiorImageSavedSubtitle,
      primaryLabel: AppStrings.interiorDone,
    );
  }

  void _onShare() => Share.share(AppStrings.settingsShareMessage);

  Future<void> _onDelete(BuildContext context) async {
    final confirmed = await ResultActionDialog.show(
      context,
      title: AppStrings.interiorDeleteTitle,
      subtitle: AppStrings.interiorDeleteSubtitle,
      primaryLabel: AppStrings.interiorDeleteDesign,
      showCancel: true,
    );
    if (confirmed ?? false) onClose();
  }

  Future<void> _onRegeneratePressed(BuildContext context) async {
    final confirmed = await ResultActionDialog.show(
      context,
      title: AppStrings.interiorRegenerateTitle,
      subtitle: AppStrings.interiorRegenerateSubtitle,
      primaryLabel: AppStrings.interiorRegenerate,
      showCancel: true,
    );
    if (confirmed ?? false) onRegenerate();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCustom = customPrompt?.isNotEmpty ?? false;
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onShare: _onShare, onClose: onClose),
            SizedBox(height: context.height8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.width16),
                child: Image.asset(
                  AppAsset.floorResult.path,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const ColoredBox(color: AppColors.magnolia),
                ),
              ),
            ),
            SizedBox(height: context.height16),
            if (isCustom) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  AppStrings.interiorPrompt,
                  style: TextStyle(
                    color: AppColors.smokyBlack,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: context.height10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.width16),
                decoration: BoxDecoration(
                  color: AppColors.cloudGray,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  customPrompt!,
                  style: const TextStyle(
                    color: AppColors.smokyBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(height: context.height16),
            ],
            ResultSegmentChip(
              label: AppStrings.floorMaterial,
              value: materialLabel,
            ),
            SizedBox(height: context.height20),
            Row(
              children: [
                _CircleIconButton(
                  icon: Icons.delete_outline_rounded,
                  onTap: () => _onDelete(context),
                ),
                SizedBox(width: context.width12),
                _CircleIconButton(
                  icon: Icons.refresh_rounded,
                  onTap: () => _onRegeneratePressed(context),
                ),
                SizedBox(width: context.width12),
                Expanded(
                  child: GradientButton(
                    text: AppStrings.interiorSaveButton,
                    onPressed: () => _onSave(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.height16),
          ],
        ).symmetricPadding(horizontal: context.width24),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onShare, required this.onClose});

  final VoidCallback onShare;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            AppStrings.interiorResultHeader,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
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
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: context.width52,
        height: context.width52,
        decoration: const BoxDecoration(
          color: AppColors.cloudGray,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: context.width24, color: AppColors.smokyBlack),
      ),
    );
  }
}
