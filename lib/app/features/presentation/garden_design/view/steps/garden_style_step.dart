import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/custom_style_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/style_grid_item.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_state.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_style.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class GardenStyleStep extends StatelessWidget {
  const GardenStyleStep({super.key, required this.state});

  final GardenDesignState state;

  Future<void> _onSelect(BuildContext context, GardenStyle style) async {
    final cubit = context.read<GardenDesignCubit>();
    cubit.selectStyle(style);
    if (!style.isCustom) return;
    final prompt = await CustomStyleBottomSheet.show(
      context,
      promptLibrary: AppStrings.gardenPromptLibraryItems,
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
            AppStrings.interiorSelectStyleTitle,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.height4),
          const Text(
            AppStrings.interiorSelectStyleSubtitle,
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
            itemCount: GardenStyle.values.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.width12,
              mainAxisSpacing: context.height12,
              childAspectRatio: 0.92,
            ),
            itemBuilder: (context, index) {
              final style = GardenStyle.values[index];
              return StyleGridItem(
                label: style.label,
                isCustom: style.isCustom,
                imageAsset: style.isCustom ? null : style.previewImage,
                isSelected: state.style == style,
                isDimmed: state.style != null && state.style != style,
                onTap: () => _onSelect(context, style),
              );
            },
          ),
        ],
      ),
    );
  }
}
