import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_action_bar.dart';
import 'package:interior_ai/app/common/widgets/result_layout.dart';
import 'package:interior_ai/app/common/widgets/result_segment_chip.dart';
import 'package:interior_ai/core/helpers/app_share.dart';

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
    await context.read<CollectionCubit>().saveToGallery(
          AppAsset.floorResult.path,
        );
    if (!context.mounted) return;
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
    return ResultLayout(
      imagePath: AppAsset.floorResult.path,
      onShare: () => AppShare.image(context, AppAsset.floorResult.path),
      onClose: onClose,
      prompt: customPrompt,
      details: ResultSegmentChip(
        label: AppStrings.floorMaterial,
        value: materialLabel,
      ),
      footer: ResultActionBar(
        onDelete: () => _onDelete(context),
        onRegenerate: () => _onRegeneratePressed(context),
        onSave: () => _onSave(context),
      ),
    );
  }
}
