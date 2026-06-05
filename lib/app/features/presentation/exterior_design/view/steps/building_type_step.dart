import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/style_grid_item.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_state.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/building_type.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class BuildingTypeStep extends StatelessWidget {
  const BuildingTypeStep({super.key, required this.state});

  final ExteriorDesignState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExteriorDesignCubit>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: context.height16, bottom: context.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.exteriorBuildingTypeTitle,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.height4),
          const Text(
            AppStrings.exteriorBuildingTypeSubtitle,
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
            itemCount: BuildingType.values.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.width12,
              mainAxisSpacing: context.height12,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final type = BuildingType.values[index];
              return StyleGridItem(
                label: type.label,
                isCustom: false,
                imageAsset: type.image,
                isSelected: state.buildingType == type,
                isDimmed:
                    state.buildingType != null && state.buildingType != type,
                onTap: () => cubit.selectBuildingType(type),
              );
            },
          ),
        ],
      ),
    );
  }
}
