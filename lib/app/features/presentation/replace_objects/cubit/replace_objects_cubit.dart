import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_state.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/enums/replace_objects_step.dart';

final class ReplaceObjectsCubit extends Cubit<ReplaceObjectsState> {
  ReplaceObjectsCubit() : super(const ReplaceObjectsState());

  String get _samplePhoto => AppOnboardingResultSpaceImage.livingRoom.basePath();

  void reset() => emit(const ReplaceObjectsState());

  void addSamplePhoto() => emit(state.copyWith(photoPath: _samplePhoto));

  void setPhoto(String path) => emit(state.copyWith(photoPath: path));

  void removePhoto() => emit(state.copyWith(clearPhoto: true));

  void setPrompt(String prompt) => emit(state.copyWith(prompt: prompt));

  void selectResult(int index) =>
      emit(state.copyWith(selectedResultIndex: index));

  Future<void> generate() async {
    emit(state.copyWith(
      step: ReplaceObjectsStep.processing,
      selectedResultIndex: 0,
    ));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed && state.step == ReplaceObjectsStep.processing) {
      emit(state.copyWith(step: ReplaceObjectsStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: ReplaceObjectsStep.error));

  void retry() => generate();
}
