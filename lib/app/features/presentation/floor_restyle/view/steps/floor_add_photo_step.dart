import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/add_photo_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/dialogs/remove_photo_dialog.dart';
import 'package:interior_ai/app/common/widgets/photo_input_step.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_cubit.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_state.dart';

class FloorAddPhotoStep extends StatelessWidget {
  const FloorAddPhotoStep({super.key, required this.state});

  final FloorRestyleState state;

  Future<void> _onAddPressed(BuildContext context) async {
    final cubit = context.read<FloorRestyleCubit>();
    final source = await AddPhotoBottomSheet.show(context);
    if (source == null) return;
    cubit.addSamplePhoto();
  }

  Future<void> _onRemovePressed(BuildContext context) async {
    final cubit = context.read<FloorRestyleCubit>();
    final shouldRemove = await RemovePhotoDialog.show(context);
    if (shouldRemove ?? false) cubit.removePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FloorRestyleCubit>();
    return PhotoInputStep(
      label: AppStrings.interiorAddYourPhoto,
      photoPath: state.selectedPhotoPath,
      exampleIndex: state.exampleIndex,
      photos: kFloorExamplePhotos,
      onAdd: () => _onAddPressed(context),
      onRemove: () => _onRemovePressed(context),
      onSelectExample: cubit.selectExample,
    );
  }
}
