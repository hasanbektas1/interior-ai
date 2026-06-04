import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/add_photo_bottom_sheet.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/example_photo_list.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/photo_picker_box.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/remove_photo_dialog.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class AddPhotoStep extends StatelessWidget {
  const AddPhotoStep({super.key, required this.state});

  final InteriorDesignState state;

  Future<void> _onAddPressed(BuildContext context) async {
    final cubit = context.read<InteriorDesignCubit>();
    final source = await AddPhotoBottomSheet.show(context);
    if (source == null) return;
    cubit.addSamplePhoto();
  }

  Future<void> _onRemovePressed(BuildContext context) async {
    final cubit = context.read<InteriorDesignCubit>();
    final shouldRemove = await RemovePhotoDialog.show(context);
    if (shouldRemove ?? false) cubit.removePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InteriorDesignCubit>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: context.height20, bottom: context.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.interiorAddYourPhoto,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.height12),
          PhotoPickerBox(
            photoPath: state.selectedPhotoPath,
            onAdd: () => _onAddPressed(context),
            onRemove: () => _onRemovePressed(context),
          ),
          SizedBox(height: context.height24),
          const Text(
            AppStrings.interiorUseExamplePhoto,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.height12),
          ExamplePhotoList(
            selectedIndex: state.exampleIndex,
            onSelect: cubit.selectExample,
          ),
        ],
      ),
    );
  }
}
