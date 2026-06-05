import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_step.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_style.dart';

const List<AppAsset> kGardenExamplePhotos = [
  AppAsset.gardenExample1,
  AppAsset.gardenExample2,
  AppAsset.gardenExample3,
];

final class GardenDesignState extends Equatable {
  final GardenStep step;
  final int? exampleIndex;
  final String? addedPhotoPath;
  final GardenStyle? style;
  final String? customPrompt;

  const GardenDesignState({
    this.step = GardenStep.addPhoto,
    this.exampleIndex,
    this.addedPhotoPath,
    this.style,
    this.customPrompt,
  });

  GardenDesignState copyWith({
    GardenStep? step,
    int? exampleIndex,
    String? addedPhotoPath,
    GardenStyle? style,
    String? customPrompt,
    bool clearExample = false,
    bool clearAddedPhoto = false,
    bool clearCustomPrompt = false,
  }) {
    return GardenDesignState(
      step: step ?? this.step,
      exampleIndex: clearExample ? null : (exampleIndex ?? this.exampleIndex),
      addedPhotoPath:
          clearAddedPhoto ? null : (addedPhotoPath ?? this.addedPhotoPath),
      style: style ?? this.style,
      customPrompt:
          clearCustomPrompt ? null : (customPrompt ?? this.customPrompt),
    );
  }

  String? get selectedPhotoPath {
    if (addedPhotoPath != null) return addedPhotoPath;
    if (exampleIndex != null) return kGardenExamplePhotos[exampleIndex!].path;
    return null;
  }

  bool get canContinue => switch (step) {
        GardenStep.addPhoto => selectedPhotoPath != null,
        GardenStep.style => style != null &&
            (style != GardenStyle.custom ||
                (customPrompt?.trim().isNotEmpty ?? false)),
        GardenStep.processing => false,
        GardenStep.result => false,
        GardenStep.error => false,
      };

  @override
  List<Object?> get props =>
      [step, exampleIndex, addedPhotoPath, style, customPrompt];
}
