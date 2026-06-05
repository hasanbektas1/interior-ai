import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_material.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_step.dart';

const List<AppAsset> kFloorExamplePhotos = [
  AppAsset.floorExample1,
  AppAsset.floorExample2,
  AppAsset.floorExample3,
  AppAsset.floorExample4,
];

final class FloorRestyleState extends Equatable {
  final FloorStep step;
  final int? exampleIndex;
  final String? addedPhotoPath;
  final bool hasPainted;
  final FloorMaterial? material;
  final String? customPrompt;

  const FloorRestyleState({
    this.step = FloorStep.addPhoto,
    this.exampleIndex,
    this.addedPhotoPath,
    this.hasPainted = false,
    this.material,
    this.customPrompt,
  });

  FloorRestyleState copyWith({
    FloorStep? step,
    int? exampleIndex,
    String? addedPhotoPath,
    bool? hasPainted,
    FloorMaterial? material,
    String? customPrompt,
    bool clearExample = false,
    bool clearAddedPhoto = false,
    bool clearCustomPrompt = false,
  }) {
    return FloorRestyleState(
      step: step ?? this.step,
      exampleIndex: clearExample ? null : (exampleIndex ?? this.exampleIndex),
      addedPhotoPath:
          clearAddedPhoto ? null : (addedPhotoPath ?? this.addedPhotoPath),
      hasPainted: hasPainted ?? this.hasPainted,
      material: material ?? this.material,
      customPrompt:
          clearCustomPrompt ? null : (customPrompt ?? this.customPrompt),
    );
  }

  String? get selectedPhotoPath {
    if (addedPhotoPath != null) return addedPhotoPath;
    if (exampleIndex != null) return kFloorExamplePhotos[exampleIndex!].path;
    return null;
  }

  bool get canContinue => switch (step) {
        FloorStep.addPhoto => selectedPhotoPath != null,
        FloorStep.paint => hasPainted,
        FloorStep.material => material != null &&
            (material != FloorMaterial.custom ||
                (customPrompt?.trim().isNotEmpty ?? false)),
        FloorStep.processing => false,
        FloorStep.result => false,
        FloorStep.error => false,
      };

  @override
  List<Object?> get props => [
        step,
        exampleIndex,
        addedPhotoPath,
        hasPainted,
        material,
        customPrompt,
      ];
}
