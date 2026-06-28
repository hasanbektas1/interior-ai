import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/add_photo_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/dialogs/remove_photo_dialog.dart';
import 'package:interior_ai/app/common/widgets/photo_input_step.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_state.dart';

class GardenAddPhotoStep extends StatelessWidget {
  const GardenAddPhotoStep({super.key, required this.state});

  final GardenDesignState state;

  Future<void> _onAddPressed(BuildContext context) async {
    final cubit = context.read<GardenDesignCubit>();
    final source = await AddPhotoBottomSheet.show(context);
    switch (source) {
      case PhotoSource.camera:
        await cubit.pickPhotoFromCamera();
      case PhotoSource.library:
        await cubit.pickPhotoFromGallery();
      case PhotoSource.example:
      case null:
        break;
    }
  }

  Future<void> _onRemovePressed(BuildContext context) async {
    final cubit = context.read<GardenDesignCubit>();
    final shouldRemove = await RemovePhotoDialog.show(context);
    if (shouldRemove ?? false) cubit.removePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GardenDesignCubit>();
    return PhotoInputStep(
      label: AppStrings.interiorAddYourPhoto,
      photoPath: state.selectedPhotoPath,
      exampleIndex: state.exampleIndex,
      photos: kGardenExamplePhotos,
      onAdd: () => _onAddPressed(context),
      onRemove: () => _onRemovePressed(context),
      onSelectExample: cubit.selectExample,
    );
  }
}
