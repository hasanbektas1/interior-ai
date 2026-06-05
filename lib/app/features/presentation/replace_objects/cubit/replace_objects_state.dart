import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/enums/replace_objects_step.dart';

const List<AppAsset> kReplaceExamplePhotos = [
  AppAsset.onboardingSelectBedroom,
  AppAsset.onboardingSelectWorkspace,
  AppAsset.onboardingSelectLivingRoom,
  AppAsset.onboardingSelectDiningRoom,
  AppAsset.onboardingSelectGreySofa,
  AppAsset.onboardingSelectArmchair,
];

final class ReplaceObjectsState extends Equatable {
  final ReplaceObjectsStep step;
  final String? photoPath;
  final String prompt;

  const ReplaceObjectsState({
    this.step = ReplaceObjectsStep.editor,
    this.photoPath,
    this.prompt = '',
  });

  ReplaceObjectsState copyWith({
    ReplaceObjectsStep? step,
    String? photoPath,
    String? prompt,
    bool clearPhoto = false,
  }) {
    return ReplaceObjectsState(
      step: step ?? this.step,
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      prompt: prompt ?? this.prompt,
    );
  }

  bool get canGenerate => photoPath != null && prompt.trim().isNotEmpty;

  @override
  List<Object?> get props => [step, photoPath, prompt];
}
