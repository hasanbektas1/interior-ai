import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/onboarding/cubit/onboarding_state.dart';
import 'package:interior_ai/app/features/presentation/onboarding/onboarding_models.dart';

final class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required CollectionCubit collectionCubit})
    : _collectionCubit = collectionCubit,
      super(const OnboardingState());

  final CollectionCubit _collectionCubit;

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
    final space = state.selectedSpace!;
    final style = state.selectedStyle!;
    // Persist the onboarding design to the collection just like every other
    // flow: a generating placeholder now, flipped to the result when ready.
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.interiorDesign,
      title: AppStrings.interiorCollectionTitle,
      placeholderImagePath: space.selectAsset,
      styleLabel: style.label,
    );
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;
    await _collectionCubit.completeGenerating(id, space.resultForStyle(style));
    emit(state.copyWith(step: OnboardingStep.dreamSpace));
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
        break;
    }
  }
}
