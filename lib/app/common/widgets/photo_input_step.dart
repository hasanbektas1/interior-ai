import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/example_photo_list.dart';
import 'package:interior_ai/app/common/widgets/photo_picker_box.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class PhotoInputStep extends StatelessWidget {
  const PhotoInputStep({
    super.key,
    required this.label,
    required this.photoPath,
    required this.exampleIndex,
    required this.photos,
    required this.onAdd,
    required this.onRemove,
    required this.onSelectExample,
  });

  final String label;
  final String? photoPath;
  final int? exampleIndex;
  final List<AppAsset> photos;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final ValueChanged<int> onSelectExample;

  @override
  Widget build(BuildContext context) {
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
            onAdd: onAdd,
            onRemove: onRemove,
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
          onSelect: onSelectExample,
        ),
        SizedBox(height: context.height8),
      ],
    );
  }
}
