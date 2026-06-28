import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/result_action_dialog.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_state.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/app/features/presentation/collection/view/collection_result_view.dart';
import 'package:interior_ai/app/features/presentation/collection/widgets/collection_card.dart';
import 'package:interior_ai/app/features/presentation/collection/widgets/collection_empty.dart';
import 'package:interior_ai/app/features/presentation/collection/widgets/collection_filter_chips.dart';
import 'package:interior_ai/app/features/presentation/collection/widgets/collection_item_menu.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:share_plus/share_plus.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  void _openResult(BuildContext context, CollectionItem item) {
    final cubit = context.read<CollectionCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CollectionResultView(
          item: item,
          onClose: () => Navigator.of(context).maybePop(),
          onDeleted: () {
            cubit.deleteItem(item.id);
            Navigator.of(context).maybePop();
          },
        ),
      ),
    );
  }

  Future<void> _openMenu(
    BuildContext context,
    CollectionItem item,
    RelativeRect position,
  ) async {
    final cubit = context.read<CollectionCubit>();
    final action = await CollectionItemMenu.show(context, position);
    if (action == null || !context.mounted) return;
    switch (action) {
      case CollectionMenuAction.download:
        await cubit.saveToGallery(item.imagePath);
        if (!context.mounted) return;
        await ResultActionDialog.show(
          context,
          title: AppStrings.interiorImageSavedTitle,
          subtitle: AppStrings.interiorImageSavedSubtitle,
          primaryLabel: AppStrings.interiorDone,
        );
      case CollectionMenuAction.share:
        Share.share(AppStrings.settingsShareMessage);
      case CollectionMenuAction.delete:
        final confirmed = await ResultActionDialog.show(
          context,
          title: AppStrings.interiorDeleteTitle,
          subtitle: AppStrings.interiorDeleteSubtitle,
          primaryLabel: AppStrings.interiorDeleteDesign,
          showCancel: true,
        );
        if (confirmed ?? false) cubit.deleteItem(item.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      appBar: AppBar(
        backgroundColor: AppColors.ghostWhite,
        surfaceTintColor: AppColors.ghostWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.collectionTitle,
          style: TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, state) {
          final cubit = context.read<CollectionCubit>();
          if (state.isEmpty) return const CollectionEmpty();

          final items = state.visibleItems;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width20),
                child: CollectionFilterChips(
                  selected: state.filter,
                  onSelect: cubit.selectFilter,
                ),
              ),
              SizedBox(height: context.height16),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    context.width20,
                    0,
                    context.width20,
                    context.height24,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: context.height16),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CollectionCard(
                      item: item,
                      onTap: () => _openResult(context, item),
                      onMenu: (position) => _openMenu(context, item, position),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
