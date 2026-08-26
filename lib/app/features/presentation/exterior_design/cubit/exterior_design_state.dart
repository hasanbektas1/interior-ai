import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/building_type.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/exterior_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/color_palette.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/exterior_style.dart';

const List<AppAsset> kExteriorExamplePhotos = [
  AppAsset.exteriorExample1,
  AppAsset.exteriorExample2,
  AppAsset.exteriorExample3,
  AppAsset.exteriorExample4,
];

final class ExteriorDesignState extends Equatable {
  final ExteriorStep step;
  final int? exampleIndex;
  final String? addedPhotoPath;
  final BuildingType? buildingType;
  final ExteriorStyle? style;
  final String? customPrompt;
  final ColorPalette? colorPalette;
  final String? resultImagePath;

  const ExteriorDesignState({
    this.step = ExteriorStep.addPhoto,
    this.exampleIndex,
    this.addedPhotoPath,
    this.buildingType,
    this.style,
    this.customPrompt,
    this.colorPalette,
    this.resultImagePath,
  });

  ExteriorDesignState copyWith({
    ExteriorStep? step,
    int? exampleIndex,
    String? addedPhotoPath,
    BuildingType? buildingType,
    ExteriorStyle? style,
    String? customPrompt,
    ColorPalette? colorPalette,
    String? resultImagePath,
    bool clearExample = false,
    bool clearAddedPhoto = false,
    bool clearCustomPrompt = false,
  }) {
    return ExteriorDesignState(
      step: step ?? this.step,
      exampleIndex: clearExample ? null : (exampleIndex ?? this.exampleIndex),
      addedPhotoPath: clearAddedPhoto
          ? null
          : (addedPhotoPath ?? this.addedPhotoPath),
      buildingType: buildingType ?? this.buildingType,
      style: style ?? this.style,
      customPrompt: clearCustomPrompt
          ? null
          : (customPrompt ?? this.customPrompt),
      colorPalette: colorPalette ?? this.colorPalette,
      resultImagePath: resultImagePath ?? this.resultImagePath,
    );
  }

  String? get selectedPhotoPath {
    if (addedPhotoPath != null) return addedPhotoPath;
    if (exampleIndex != null) return kExteriorExamplePhotos[exampleIndex!].path;
    return null;
  }

  bool get canContinue => switch (step) {
    ExteriorStep.addPhoto => selectedPhotoPath != null,
    ExteriorStep.buildingType => buildingType != null,
    ExteriorStep.style =>
      style != null &&
          (style != ExteriorStyle.custom ||
              (customPrompt?.trim().isNotEmpty ?? false)),
    ExteriorStep.colorPalette => colorPalette != null,
    ExteriorStep.processing => false,
    ExteriorStep.result => false,
    ExteriorStep.error => false,
  };

  @override
  List<Object?> get props => [
    step,
    exampleIndex,
    addedPhotoPath,
    buildingType,
    style,
    customPrompt,
    colorPalette,
    resultImagePath,
  ];
}
