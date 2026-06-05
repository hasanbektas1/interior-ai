import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_state.dart';
import 'package:interior_ai/app/features/presentation/style_reference/enums/style_reference_step.dart';

final class StyleReferenceCubit extends Cubit<StyleReferenceState> {
  StyleReferenceCubit() : super(const StyleReferenceState());

  String get _samplePhoto => AppOnboardingResultSpaceImage.livingRoom.basePath();

  void reset() => emit(const StyleReferenceState());

  void selectExample(int index) {
    if (state.step == StyleReferenceStep.yourPhoto) {
      emit(state.copyWith(photoIndex: index, clearPhotoPath: true));
      return;
    }
    emit(state.copyWith(refIndex: index, clearRefPath: true));
  }

  void addSamplePhoto() {
    if (state.step == StyleReferenceStep.yourPhoto) {
      emit(state.copyWith(photoPath: _samplePhoto, clearPhotoIndex: true));
      return;
    }
    emit(state.copyWith(refPath: _samplePhoto, clearRefIndex: true));
  }

  void removePhoto() {
    if (state.step == StyleReferenceStep.yourPhoto) {
      emit(state.copyWith(clearPhotoIndex: true, clearPhotoPath: true));
      return;
    }
    emit(state.copyWith(clearRefIndex: true, clearRefPath: true));
  }

  void next() {
    switch (state.step) {
      case StyleReferenceStep.yourPhoto:
        emit(state.copyWith(step: StyleReferenceStep.referencePhoto));
      case StyleReferenceStep.referencePhoto:
        startProcessing();
      case StyleReferenceStep.processing:
      case StyleReferenceStep.result:
      case StyleReferenceStep.error:
        break;
    }
  }

  void back() {
    if (state.step == StyleReferenceStep.referencePhoto) {
      emit(state.copyWith(step: StyleReferenceStep.yourPhoto));
    }
  }

  Future<void> startProcessing() async {
    emit(state.copyWith(step: StyleReferenceStep.processing));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed && state.step == StyleReferenceStep.processing) {
      emit(state.copyWith(step: StyleReferenceStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: StyleReferenceStep.error));

  void retry() => startProcessing();
}
