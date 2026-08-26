import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/style_reference/enums/style_reference_step.dart';

const List<AppAsset> kStylePhotos = [
  AppAsset.onboardingSelectBedroom,
  AppAsset.onboardingSelectWorkspace,
  AppAsset.onboardingSelectLivingRoom,
  AppAsset.onboardingSelectDiningRoom,
  AppAsset.onboardingSelectArmchair,
  AppAsset.onboardingSelectGreySofa,
];

const List<AppAsset> kReferencePhotos = [
  AppAsset.onboardingSelectDiningRoom,
  AppAsset.onboardingSelectLivingRoom,
  AppAsset.onboardingSelectBedroom,
  AppAsset.onboardingSelectArmchair,
  AppAsset.onboardingSelectWorkspace,
  AppAsset.onboardingSelectGreySofa,
];

final class StyleReferenceState extends Equatable {
  final StyleReferenceStep step;
  final int? photoIndex;
  final String? photoPath;
  final int? refIndex;
  final String? refPath;
  final String? resultImagePath;

  const StyleReferenceState({
    this.step = StyleReferenceStep.yourPhoto,
    this.photoIndex,
    this.photoPath,
    this.refIndex,
    this.refPath,
    this.resultImagePath,
  });

  StyleReferenceState copyWith({
    StyleReferenceStep? step,
    int? photoIndex,
    String? photoPath,
    int? refIndex,
    String? refPath,
    String? resultImagePath,
    bool clearPhotoIndex = false,
    bool clearPhotoPath = false,
    bool clearRefIndex = false,
    bool clearRefPath = false,
  }) {
    return StyleReferenceState(
      step: step ?? this.step,
      photoIndex: clearPhotoIndex ? null : (photoIndex ?? this.photoIndex),
      photoPath: clearPhotoPath ? null : (photoPath ?? this.photoPath),
      refIndex: clearRefIndex ? null : (refIndex ?? this.refIndex),
      refPath: clearRefPath ? null : (refPath ?? this.refPath),
      resultImagePath: resultImagePath ?? this.resultImagePath,
    );
  }

  String? get photoSelectedPath {
    if (photoPath != null) return photoPath;
    if (photoIndex != null) return kStylePhotos[photoIndex!].path;
    return null;
  }

  String? get refSelectedPath {
    if (refPath != null) return refPath;
    if (refIndex != null) return kReferencePhotos[refIndex!].path;
    return null;
  }

  bool get canContinue => switch (step) {
    StyleReferenceStep.yourPhoto => photoSelectedPath != null,
    StyleReferenceStep.referencePhoto => refSelectedPath != null,
    StyleReferenceStep.processing => false,
    StyleReferenceStep.result => false,
    StyleReferenceStep.error => false,
  };

  @override
  List<Object?> get props => [
    step,
    photoIndex,
    photoPath,
    refIndex,
    refPath,
    resultImagePath,
  ];
}
