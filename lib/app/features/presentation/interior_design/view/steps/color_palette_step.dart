import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/color_palette.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/color_palette_tile.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ColorPaletteStep extends StatelessWidget {
  const ColorPaletteStep({super.key, required this.state});

  final InteriorDesignState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InteriorDesignCubit>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: context.height16, bottom: context.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.interiorChoosePaletteTitle,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.height16),
          for (final palette in ColorPalette.values)
            Padding(
              padding: EdgeInsets.only(bottom: context.height12),
              child: ColorPaletteTile(
                palette: palette,
                isSelected: state.colorPalette == palette,
                isDimmed:
                    state.colorPalette != null && state.colorPalette != palette,
                onTap: () => cubit.selectColorPalette(palette),
              ),
            ),
        ],
      ),
    );
  }
}
