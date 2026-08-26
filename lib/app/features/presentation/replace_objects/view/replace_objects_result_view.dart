import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_action_bar.dart';
import 'package:interior_ai/app/common/widgets/result_layout.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_state.dart';
import 'package:interior_ai/core/helpers/app_share.dart';
import 'package:interior_ai/core/widgets/snackbar/app_snackbar.dart';

class ReplaceObjectsResultView extends StatelessWidget {
  const ReplaceObjectsResultView({
    super.key,
    required this.state,
    required this.onClose,
    required this.onDelete,
    required this.onRegenerate,
  });

  final ReplaceObjectsState state;
  final VoidCallback onClose;
  final VoidCallback onDelete;
  final VoidCallback onRegenerate;

  Future<void> _onSave(BuildContext context) async {
    final ok = await context.read<CollectionCubit>().saveToGallery(
      state.resultImagePath ?? '',
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
    final imagePath = state.resultImagePath ?? '';
    return ResultLayout(
      imagePath: imagePath,
      onShare: () => AppShare.image(context, imagePath),
      onClose: onClose,
      prompt: state.prompt,
      footer: ResultActionBar(
        onDelete: () => _onDelete(context),
        onRegenerate: () => _onRegeneratePressed(context),
        onSave: () => _onSave(context),
      ),
    );
  }
}
