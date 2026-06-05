import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/buttons/gradient_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';
import 'package:share_plus/share_plus.dart';

class StyleReferenceResultView extends StatelessWidget {
  const StyleReferenceResultView({
    super.key,
    required this.onClose,
    required this.onRegenerate,
  });

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

  void _onShare() {
    Share.share(AppStrings.settingsShareMessage);
  }

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
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
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
                      onTap: _onShare,
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
            ),
            SizedBox(height: context.height8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.width16),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    AppAsset.interiorResult.path,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const ColoredBox(color: AppColors.magnolia),
                  ),
                ),
              ),
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
