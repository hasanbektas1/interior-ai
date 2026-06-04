import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/gradient_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_info_chip.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';
import 'package:share_plus/share_plus.dart';

class CollectionResultView extends StatelessWidget {
  const CollectionResultView({
    super.key,
    required this.item,
    required this.onClose,
    required this.onDeleted,
  });

  final CollectionItem item;
  final VoidCallback onClose;
  final VoidCallback onDeleted;

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
    if (!(confirmed ?? false) || !context.mounted) return;
    await ResultActionDialog.show(
      context,
      title: AppStrings.collectionDesignDeletedTitle,
      subtitle: AppStrings.collectionDesignDeletedSubtitle,
      primaryLabel: AppStrings.interiorDone,
    );
    onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: item.title, onShare: _onShare, onClose: onClose),
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
                          item.image.path,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const ColoredBox(color: AppColors.magnolia),
                        ),
                      ),
                    ),
                    SizedBox(height: context.height20),
                    if (item.prompt?.isNotEmpty ?? false)
                      _PromptSection(prompt: item.prompt!),
                    Row(
                      children: [
                        Expanded(
                          child: ResultInfoChip(
                            label: AppStrings.interiorRoomType,
                            value: item.roomType.label,
                            icon: item.roomType.icon,
                          ),
                        ),
                        SizedBox(width: context.width12),
                        Expanded(
                          child: ResultInfoChip(
                            label: AppStrings.interiorStyle,
                            value: item.styleLabel,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onDelete(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.width8),
                    child: const Text(
                      AppStrings.collectionDelete,
                      style: TextStyle(
                        color: AppColors.nickel,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
  const _Header({
    required this.title,
    required this.onShare,
    required this.onClose,
  });

  final String title;
  final VoidCallback onShare;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
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
