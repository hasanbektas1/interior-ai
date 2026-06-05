import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/dialogs/add_photo_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/dialogs/remove_photo_dialog.dart';
import 'package:interior_ai/app/common/widgets/example_photo_list.dart';
import 'package:interior_ai/app/common/widgets/photo_picker_box.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_cubit.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

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
    if (source == null) return;
    cubit.addSamplePhoto();
  }

  Future<void> _onRemovePressed(BuildContext context) async {
    final cubit = context.read<StyleReferenceCubit>();
    final shouldRemove = await RemovePhotoDialog.show(context);
    if (shouldRemove ?? false) cubit.removePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StyleReferenceCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.height24),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.height12),
        Expanded(
          child: PhotoPickerBox(
            photoPath: photoPath,
            onAdd: () => _onAddPressed(context),
            onRemove: () => _onRemovePressed(context),
          ),
        ),
        SizedBox(height: context.height20),
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
          photos: photos,
          selectedIndex: exampleIndex,
          onSelect: cubit.selectExample,
        ),
        SizedBox(height: context.height8),
      ],
    );
  }
}
