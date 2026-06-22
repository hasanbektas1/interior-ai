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

const List<AppAsset> kReplaceResultVariants = [
  AppAsset.onboardingSelectLivingRoom,
  AppAsset.onboardingSelectDiningRoom,
  AppAsset.onboardingSelectArmchair,
  AppAsset.onboardingSelectGreySofa,
  AppAsset.onboardingSelectBedroom,
];

final class ReplaceObjectsState extends Equatable {
  final ReplaceObjectsStep step;
  final String? photoPath;
  final String prompt;
  final int selectedResultIndex;

  const ReplaceObjectsState({
    this.step = ReplaceObjectsStep.editor,
    this.photoPath,
    this.prompt = '',
    this.selectedResultIndex = 0,
  });

  ReplaceObjectsState copyWith({
    ReplaceObjectsStep? step,
    String? photoPath,
    String? prompt,
    int? selectedResultIndex,
    bool clearPhoto = false,
  }) {
    return ReplaceObjectsState(
      step: step ?? this.step,
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      prompt: prompt ?? this.prompt,
      selectedResultIndex: selectedResultIndex ?? this.selectedResultIndex,
    );
  }

  bool get canGenerate => photoPath != null && prompt.trim().isNotEmpty;

  AppAsset get selectedResult => kReplaceResultVariants[selectedResultIndex];

  @override
  List<Object?> get props => [step, photoPath, prompt, selectedResultIndex];
}
