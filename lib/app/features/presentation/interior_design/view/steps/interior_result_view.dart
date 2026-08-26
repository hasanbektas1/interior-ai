import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_info_chip.dart';
import 'package:interior_ai/app/common/widgets/result_layout.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/common/widgets/result_action_bar.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/helpers/app_share.dart';
import 'package:interior_ai/core/widgets/snackbar/app_snackbar.dart';

class InteriorResultView extends StatelessWidget {
  const InteriorResultView({
    super.key,
    required this.state,
    required this.onClose,
    required this.onDelete,
    required this.onRegenerate,
  });

  final InteriorDesignState state;
  final VoidCallback onClose;
  final VoidCallback onDelete;
  final VoidCallback onRegenerate;

  Future<void> _onSave(BuildContext context) async {
    final ok = await context.read<CollectionCubit>().saveToGallery(
      state.resultImagePath ?? AppAsset.interiorResult.path,
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
    if (confirmed ?? false) onDelete();
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
    final bool hasPrompt =
        state.isCustomStyle && (state.customPrompt?.isNotEmpty ?? false);
    final imagePath = state.resultImagePath ?? AppAsset.interiorResult.path;
    return ResultLayout(
      imagePath: imagePath,
      onShare: () => AppShare.image(context, imagePath),
      onClose: onClose,
      prompt: hasPrompt ? state.customPrompt : null,
      details: Row(
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
      footer: ResultActionBar(
        onDelete: () => _onDelete(context),
        onRegenerate: () => _onRegenerate(context),
        onSave: () => _onSave(context),
      ),
    );
  }
}
