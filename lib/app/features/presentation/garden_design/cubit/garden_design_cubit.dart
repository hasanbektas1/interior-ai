import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_state.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_step.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_style.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';

final class GardenDesignCubit extends Cubit<GardenDesignState> {
  GardenDesignCubit({required MediaPickerService mediaPickerService})
      : _mediaPickerService = mediaPickerService,
        super(const GardenDesignState());

  final MediaPickerService _mediaPickerService;

  void reset() => emit(const GardenDesignState());

  void selectExample(int index) {
    emit(state.copyWith(exampleIndex: index, clearAddedPhoto: true));
  }

  Future<void> pickPhotoFromCamera() async {
    final path = await _mediaPickerService.pickFromCamera();
    if (path == null || isClosed) return;
    emit(state.copyWith(addedPhotoPath: path, clearExample: true));
  }

  Future<void> pickPhotoFromGallery() async {
    final path = await _mediaPickerService.pickFromGallery();
    if (path == null || isClosed) return;
    emit(state.copyWith(addedPhotoPath: path, clearExample: true));
  }

  void removePhoto() {
    emit(state.copyWith(clearExample: true, clearAddedPhoto: true));
  }

  void selectStyle(GardenStyle style) {
    if (style != GardenStyle.custom) {
      emit(state.copyWith(style: style, clearCustomPrompt: true));
      return;
    }
    emit(state.copyWith(style: style));
  }

  void setCustomPrompt(String prompt) {
    emit(state.copyWith(style: GardenStyle.custom, customPrompt: prompt));
  }

  void next() {
    switch (state.step) {
      case GardenStep.addPhoto:
        emit(state.copyWith(step: GardenStep.style));
      case GardenStep.style:
        startProcessing();
      case GardenStep.processing:
      case GardenStep.result:
      case GardenStep.error:
        break;
    }
  }

  void back() {
    if (state.step == GardenStep.style) {
      emit(state.copyWith(step: GardenStep.addPhoto));
    }
  }

  Future<void> startProcessing() async {
    emit(state.copyWith(step: GardenStep.processing));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed && state.step == GardenStep.processing) {
      emit(state.copyWith(step: GardenStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: GardenStep.error));

  void retry() => startProcessing();
}
