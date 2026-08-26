import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_info_chip.dart';
import 'package:interior_ai/app/common/widgets/result_layout.dart';
import 'package:interior_ai/app/common/widgets/result_prompt_section.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/helpers/app_share.dart';
import 'package:interior_ai/core/widgets/snackbar/app_snackbar.dart';

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
    final ok = await context.read<CollectionCubit>().saveToGallery(
      item.imagePath,
    );
    if (!context.mounted) return;
    if (!ok) {
      AppSnackBar.show(AppStrings.saveFailed);
      return;
    }
    await ResultActionDialog.show(
      context,
      title: AppStrings.interiorImageSavedTitle,
      subtitle: AppStrings.interiorImageSavedSubtitle,
      primaryLabel: AppStrings.interiorDone,
    );
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
      onShare: () => AppShare.image(context, item.imagePath),
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
/// screen by showing the prompt the user typed; every other category shows
/// info chips.
class _ResultDetails extends StatelessWidget {
  const _ResultDetails({required this.item});

  final CollectionItem item;

  @override
  Widget build(BuildContext context) {
    if (item.category == CollectionCategory.replaceObject) {
      final prompt = item.prompt;
      if (prompt == null || prompt.isEmpty) {
        return const SizedBox.shrink();
      }
      return ResultPromptSection(prompt: prompt);
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
