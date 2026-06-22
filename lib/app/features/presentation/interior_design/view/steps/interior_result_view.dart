import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_info_chip.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/common/widgets/result_action_bar.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/interior_prompt_section.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/interior_result_header.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';
import 'package:share_plus/share_plus.dart';

class InteriorResultView extends StatelessWidget {
  const InteriorResultView({
    super.key,
    required this.state,
    required this.onClose,
    required this.onRegenerate,
  });

  final InteriorDesignState state;
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

  Future<void> _onRegenerate(BuildContext context) async {
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
    final imageHeight = MediaQuery.sizeOf(context).height * 0.6;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InteriorResultHeader(onShare: _onShare, onClose: onClose),
            SizedBox(height: context.height8),
            SizedBox(
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.width16),
                child: Image.asset(
                  AppAsset.interiorResult.path,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const ColoredBox(color: AppColors.magnolia),
                ),
              ),
            ),
            SizedBox(height: context.height20),
            if (state.isCustomStyle &&
                (state.customPrompt?.isNotEmpty ?? false))
              InteriorPromptSection(prompt: state.customPrompt!),
            Row(
              children: [
                Expanded(
                  child: ResultInfoChip(
                    label: AppStrings.interiorRoomType,
                    value: state.roomDisplayValue,
                    icon: state.roomType?.icon,
                  ),
                ),
                SizedBox(width: context.width12),
                Expanded(
                  child: ResultInfoChip(
                    label: AppStrings.interiorStyle,
                    value: state.styleLabel,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ResultActionBar(
              onDelete: () => _onDelete(context),
              onRegenerate: () => _onRegenerate(context),
              onSave: () => _onSave(context),
            ),
            SizedBox(height: context.height16),
          ],
        ).symmetricPadding(horizontal: context.width24),
      ),
    );
  }
}
