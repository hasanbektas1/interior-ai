import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/design_style.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/gradient_button.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/result_action_dialog.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/result_info_chip.dart';
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

  bool get _isCustom => state.style == DesignStyle.custom;

  String get _roomValue {
    final roomType = state.roomType;
    if (roomType == null) return '';
    if (roomType == RoomType.other) {
      return state.customRoomName?.trim().isNotEmpty ?? false
          ? state.customRoomName!
          : roomType.label;
    }
    return roomType.label;
  }

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
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onShare: _onShare, onClose: onClose),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: context.height16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.height8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.width16),
                      child: SizedBox(
                        width: double.infinity,
                        height: context.height340,
                        child: Image.asset(
                          AppAsset.interiorResult.path,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const ColoredBox(color: AppColors.magnolia),
                        ),
                      ),
                    ),
                    SizedBox(height: context.height20),
                    if (_isCustom && (state.customPrompt?.isNotEmpty ?? false))
                      _PromptSection(prompt: state.customPrompt!),
                    Row(
                      children: [
                        Expanded(
                          child: ResultInfoChip(
                            label: AppStrings.interiorRoomType,
                            value: _roomValue,
                            icon: state.roomType?.icon,
                          ),
                        ),
                        SizedBox(width: context.width12),
                        Expanded(
                          child: ResultInfoChip(
                            label: AppStrings.interiorStyle,
                            value: state.style?.label ?? '',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _BottomBar(
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

class _PromptSection extends StatelessWidget {
  const _PromptSection({required this.prompt});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.interiorPrompt,
          style: TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 17,
            fontWeight: FontWeight.w700,
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
            prompt,
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
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
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
        _CircleIconButton(icon: Icons.delete_outline_rounded, onTap: onDelete),
        SizedBox(width: context.width12),
        _CircleIconButton(icon: Icons.refresh_rounded, onTap: onRegenerate),
        SizedBox(width: context.width12),
        Expanded(
          child: GradientButton(
            text: AppStrings.interiorSaveButton,
            onPressed: onSave,
          ),
        ),
      ],
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
