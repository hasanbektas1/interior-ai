import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/dialogs/add_photo_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/dialogs/remove_photo_dialog.dart';
import 'package:interior_ai/app/common/widgets/photo_input_step.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_state.dart';

class ExteriorAddPhotoStep extends StatelessWidget {
  const ExteriorAddPhotoStep({super.key, required this.state});

  final ExteriorDesignState state;

  Future<void> _onAddPressed(BuildContext context) async {
    final cubit = context.read<ExteriorDesignCubit>();
    final source = await AddPhotoBottomSheet.show(context);
    if (source == null) return;
    cubit.addSamplePhoto();
  }

  Future<void> _onRemovePressed(BuildContext context) async {
    final cubit = context.read<ExteriorDesignCubit>();
    final shouldRemove = await RemovePhotoDialog.show(context);
    if (shouldRemove ?? false) cubit.removePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExteriorDesignCubit>();
    return PhotoInputStep(
      label: AppStrings.interiorAddYourPhoto,
      photoPath: state.selectedPhotoPath,
      exampleIndex: state.exampleIndex,
      photos: kExteriorExamplePhotos,
      onAdd: () => _onAddPressed(context),
      onRemove: () => _onRemovePressed(context),
      onSelectExample: cubit.selectExample,
    );
  }
}
