import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_state.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/building_type.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/exterior_color_palette.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/exterior_step.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/exterior_style.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';

final class ExteriorDesignCubit extends Cubit<ExteriorDesignState> {
  ExteriorDesignCubit({required MediaPickerService mediaPickerService})
      : _mediaPickerService = mediaPickerService,
        super(const ExteriorDesignState());

  final MediaPickerService _mediaPickerService;

  void reset() => emit(const ExteriorDesignState());

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

  void selectBuildingType(BuildingType type) {
    emit(state.copyWith(buildingType: type));
  }

  void selectStyle(ExteriorStyle style) {
    if (style != ExteriorStyle.custom) {
      emit(state.copyWith(style: style, clearCustomPrompt: true));
      return;
    }
    emit(state.copyWith(style: style));
  }

  void setCustomPrompt(String prompt) {
    emit(state.copyWith(style: ExteriorStyle.custom, customPrompt: prompt));
  }

  void selectColorPalette(ExteriorColorPalette palette) {
    emit(state.copyWith(colorPalette: palette));
  }

  void next() {
    switch (state.step) {
      case ExteriorStep.addPhoto:
        emit(state.copyWith(step: ExteriorStep.buildingType));
      case ExteriorStep.buildingType:
        emit(state.copyWith(step: ExteriorStep.style));
      case ExteriorStep.style:
        emit(state.copyWith(step: ExteriorStep.colorPalette));
      case ExteriorStep.colorPalette:
        startProcessing();
      case ExteriorStep.processing:
      case ExteriorStep.result:
      case ExteriorStep.error:
        break;
    }
  }

  void back() {
    switch (state.step) {
      case ExteriorStep.buildingType:
        emit(state.copyWith(step: ExteriorStep.addPhoto));
      case ExteriorStep.style:
        emit(state.copyWith(step: ExteriorStep.buildingType));
      case ExteriorStep.colorPalette:
        emit(state.copyWith(step: ExteriorStep.style));
      case ExteriorStep.addPhoto:
      case ExteriorStep.processing:
      case ExteriorStep.result:
      case ExteriorStep.error:
        break;
    }
  }

  Future<void> startProcessing() async {
    emit(state.copyWith(step: ExteriorStep.processing));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed && state.step == ExteriorStep.processing) {
      emit(state.copyWith(step: ExteriorStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: ExteriorStep.error));

  void retry() => startProcessing();
}
