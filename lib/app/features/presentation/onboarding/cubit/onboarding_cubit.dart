import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/onboarding/cubit/onboarding_state.dart';
import 'package:interior_ai/app/features/presentation/onboarding/onboarding_models.dart';

final class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void goToPickSpace() {
    emit(state.copyWith(step: OnboardingStep.pickSpace));
  }

  void selectSpace(OnboardingSpace space) {
    emit(state.copyWith(selectedSpace: space));
  }

  void goToFindStyle() {
    emit(state.copyWith(step: OnboardingStep.findStyle));
  }

  void selectStyle(OnboardingStyle style) {
    emit(state.copyWith(selectedStyle: style));
  }

  Future<void> processDesign() async {
    emit(state.copyWith(step: OnboardingStep.processing));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed) {
      emit(state.copyWith(step: OnboardingStep.dreamSpace));
    }
  }

  void goToHelpUsGrow() {
    emit(state.copyWith(step: OnboardingStep.helpUsGrow));
  }

  void onButtonPressed() {
    switch (state.step) {
      case OnboardingStep.welcome:
        goToPickSpace();
      case OnboardingStep.pickSpace:
        if (state.selectedSpace != null) goToFindStyle();
      case OnboardingStep.findStyle:
        if (state.selectedStyle != null) processDesign();
      case OnboardingStep.processing:
        break;
      case OnboardingStep.dreamSpace:
        goToHelpUsGrow();
      case OnboardingStep.helpUsGrow:
        // TODO: Navigate to main app
        break;
    }
  }
}
