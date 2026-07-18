import 'package:flutter/cupertino.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';

enum PhotoSource { camera, library, example }

/// Native iOS-style action sheet for picking a photo source.
abstract final class AddPhotoBottomSheet {
  static Future<PhotoSource?> show(
    BuildContext context, {
    bool showExampleOption = false,
  }) {
    return showCupertinoModalPopup<PhotoSource>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text(AppStrings.interiorAddPhotoTitle),
        message: Text(
          showExampleOption
              ? AppStrings.replaceAddPhotoSubtitle
              : AppStrings.interiorAddPhotoSubtitle,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(PhotoSource.camera),
            child: const Text(AppStrings.interiorTakePhoto),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(PhotoSource.library),
            child: const Text(AppStrings.interiorChooseFromLibrary),
          ),
          if (showExampleOption)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(PhotoSource.example),
              child: const Text(AppStrings.interiorUseExamplePhoto),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.interiorCancel),
        ),
      ),
    );
  }
}
