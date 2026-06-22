import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/common/widgets/result_action_bar.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_cubit.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_state.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';
import 'package:share_plus/share_plus.dart';

class ReplaceObjectsResultView extends StatelessWidget {
  const ReplaceObjectsResultView({
    super.key,
    required this.state,
    required this.onClose,
    required this.onRegenerate,
  });

  final ReplaceObjectsState state;
  final VoidCallback onClose;
  final VoidCallback onRegenerate;

  Future<void> _onSave(BuildContext context) async {
    final collection = context.read<CollectionCubit>();
    final now = DateTime.now();
    collection.addItem(
      CollectionItem(
        id: now.millisecondsSinceEpoch.toString(),
        title: AppStrings.replaceObjectCollectionTitle,
        category: CollectionCategory.replaceObject,
        dateLabel: '${now.day}.${now.month}.${now.year}',
        image: state.selectedResult,
        roomType: RoomType.livingRoom,
        styleLabel: CollectionCategory.replaceObject.label,
        prompt: state.prompt.trim().isEmpty ? null : state.prompt,
      ),
    );
    if (!context.mounted) return;
    await ResultActionDialog.show(
      context,
      title: AppStrings.interiorImageSavedTitle,
      subtitle: AppStrings.interiorImageSavedSubtitle,
      primaryLabel: AppStrings.interiorDone,
    );
    if (context.mounted) onClose();
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
    final imageHeight = MediaQuery.sizeOf(context).height * 0.55;
    final cubit = context.read<ReplaceObjectsCubit>();
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onShare: _onShare, onClose: onClose),
            SizedBox(height: context.height8),
            SizedBox(
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.width16),
                child: Image.asset(
                  state.selectedResult.path,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const ColoredBox(color: AppColors.magnolia),
                ),
              ),
            ),
            SizedBox(height: context.height16),
            _VariantStrip(
              selectedIndex: state.selectedResultIndex,
              onSelect: cubit.selectResult,
            ),
            const Spacer(),
            ResultActionBar(
              onDelete: () => _onDelete(context),
              onRegenerate: () => _onRegeneratePressed(context),
              onSave: () => _onSave(context),
            ),
            SizedBox(height: context.height16),
          ],
        ).symmetricPadding(horizontal: context.width24),
      ),
    );
  }
}

class _VariantStrip extends StatelessWidget {
  const _VariantStrip({required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < kReplaceResultVariants.length; i++) ...[
          if (i != 0) SizedBox(width: context.width8),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelect(i),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.width12),
                    border: Border.all(
                      color: i == selectedIndex
                          ? AppColors.softPurple
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.width10),
                    child: Image.asset(
                      kReplaceResultVariants[i].path,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: AppColors.magnolia),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
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
