import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/custom_style_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/style_grid_item.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_cubit.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_state.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_material.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class FloorMaterialStep extends StatelessWidget {
  const FloorMaterialStep({super.key, required this.state});

  final FloorRestyleState state;

  Future<void> _onSelect(BuildContext context, FloorMaterial material) async {
    final cubit = context.read<FloorRestyleCubit>();
    cubit.selectMaterial(material);
    if (!material.isCustom) return;
    final prompt = await CustomStyleBottomSheet.show(
      context,
      promptLibrary: AppStrings.floorPromptLibraryItems,
      initialPrompt: state.customPrompt,
    );
    if (prompt != null) cubit.setCustomPrompt(prompt);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: context.height16, bottom: context.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.floorSelectMaterialTitle,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.height4),
          const Text(
            AppStrings.floorSelectMaterialSubtitle,
            style: TextStyle(
              color: AppColors.nickel,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: context.height20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: FloorMaterial.values.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.width12,
              mainAxisSpacing: context.height12,
              childAspectRatio: 0.92,
            ),
            itemBuilder: (context, index) {
              final material = FloorMaterial.values[index];
              return StyleGridItem(
                label: material.label,
                isCustom: material.isCustom,
                imageAsset: material.isCustom ? null : material.image,
                customImage: material.isCustom ? material.image : null,
                isSelected: state.material == material,
                isDimmed: state.material != null && state.material != material,
                onTap: () => _onSelect(context, material),
              );
            },
          ),
        ],
      ),
    );
  }
}
