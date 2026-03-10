import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/onboarding/onboarding_models.dart';

enum OnboardingStep {
  welcome,
  pickSpace,
  findStyle,
  processing,
  dreamSpace,
  helpUsGrow,
}

final class OnboardingState extends Equatable {
  final OnboardingStep step;
  final OnboardingSpace? selectedSpace;
  final OnboardingStyle? selectedStyle;

  const OnboardingState({
    this.step = OnboardingStep.welcome,
    this.selectedSpace,
    this.selectedStyle,
  });

  OnboardingState copyWith({
    OnboardingStep? step,
    OnboardingSpace? selectedSpace,
    OnboardingStyle? selectedStyle,
    bool clearSpaceSelection = false,
    bool clearStyleSelection = false,
  }) {
    return OnboardingState(
      step: step ?? this.step,
      selectedSpace: clearSpaceSelection
          ? null
          : (selectedSpace ?? this.selectedSpace),
      selectedStyle: clearStyleSelection
          ? null
          : (selectedStyle ?? this.selectedStyle),
    );
  }

  bool get isButtonEnabled => switch (step) {
    OnboardingStep.welcome => true,
    OnboardingStep.pickSpace => selectedSpace != null,
    OnboardingStep.findStyle => selectedStyle != null,
    OnboardingStep.processing => false,
    OnboardingStep.dreamSpace => true,
    OnboardingStep.helpUsGrow => true,
  };

  String get buttonText => step == OnboardingStep.welcome
      ? AppStrings.onboardingLetsCreate
      : AppStrings.continueButton;

  int get pageIndex => switch (step) {
    OnboardingStep.welcome => 0,
    OnboardingStep.pickSpace => 1,
    OnboardingStep.findStyle => 2,
    OnboardingStep.processing => 2,
    OnboardingStep.dreamSpace => 3,
    OnboardingStep.helpUsGrow => 4,
  };

  String get dreamMainImage {
    return selectedSpace!.resultForStyle(selectedStyle!);
  }

  String? get dreamMiniImage => selectedSpace?.miniAsset;

  @override
  List<Object?> get props => [step, selectedSpace, selectedStyle];
}
