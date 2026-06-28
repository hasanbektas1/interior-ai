import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/dialogs/add_photo_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/dialogs/remove_photo_dialog.dart';
import 'package:interior_ai/app/common/widgets/photo_input_step.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_cubit.dart';

class StyleReferencePhotoStep extends StatelessWidget {
  const StyleReferencePhotoStep({
    super.key,
    required this.label,
    required this.photoPath,
    required this.exampleIndex,
    required this.photos,
  });

  final String label;
  final String? photoPath;
  final int? exampleIndex;
  final List<AppAsset> photos;

  Future<void> _onAddPressed(BuildContext context) async {
    final cubit = context.read<StyleReferenceCubit>();
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
    final cubit = context.read<StyleReferenceCubit>();
    final shouldRemove = await RemovePhotoDialog.show(context);
    if (shouldRemove ?? false) cubit.removePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StyleReferenceCubit>();
    return PhotoInputStep(
      label: label,
      photoPath: photoPath,
      exampleIndex: exampleIndex,
      photos: photos,
      onAdd: () => _onAddPressed(context),
      onRemove: () => _onRemovePressed(context),
      onSelectExample: cubit.selectExample,
    );
  }
}
