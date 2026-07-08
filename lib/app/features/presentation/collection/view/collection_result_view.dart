import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_info_chip.dart';
import 'package:interior_ai/app/common/widgets/result_layout.dart';
import 'package:interior_ai/app/common/widgets/result_variant_strip.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_state.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
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
    await context.read<CollectionCubit>().saveToGallery(item.imagePath);
    if (!context.mounted) return;
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
    return ResultLayout(
      title: item.title,
      imagePath: item.imagePath,
      onShare: _onShare,
      onClose: onClose,
      prompt: item.prompt,
      details: _ResultDetails(item: item),
      footer: Row(
        children: [
          Expanded(
            child: AppButton(
              text: AppStrings.collectionDelete,
              onPressed: () => _onDelete(context),
              backgroundColor: AppColors.white,
              textColor: AppColors.hanPurple,
              hasBorder: true,
              borderRadius: 14,
              height: 54,
            ),
          ),
          SizedBox(width: context.width12),
          Expanded(
            child: AppButton.fill(
              text: AppStrings.interiorSaveButton,
              onPressed: () => _onSave(context),
              backgroundColor: AppColors.hanPurple,
              borderRadius: 14,
              height: 54,
            ),
          ),
        ],
      ),
    );
  }
}

/// Content shown under the image. Replace Object designs mirror their result
/// screen with the variant strip; every other category shows info chips.
class _ResultDetails extends StatelessWidget {
  const _ResultDetails({required this.item});

  final CollectionItem item;

  @override
  Widget build(BuildContext context) {
    if (item.category == CollectionCategory.replaceObject) {
      final int selectedIndex = kReplaceResultVariants
          .indexWhere((variant) => variant.path == item.imagePath);
      return ResultVariantStrip(
        variants: kReplaceResultVariants,
        selectedIndex: selectedIndex,
      );
    }
    return Row(
      children: [
        if (item.roomType != null) ...[
          Expanded(
            child: ResultInfoChip(
              label: AppStrings.interiorRoomType,
              value: item.roomType!.label,
              icon: item.roomType!.icon,
            ),
          ),
          SizedBox(width: context.width12),
        ],
        Expanded(
          child: ResultInfoChip(
            label: AppStrings.interiorStyle,
            value: item.styleLabel,
          ),
        ),
      ],
    );
  }
}
