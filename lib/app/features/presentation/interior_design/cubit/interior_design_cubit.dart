import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/color_palette.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/design_style.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/interior_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';

final class InteriorDesignCubit extends Cubit<InteriorDesignState> {
  InteriorDesignCubit({required MediaPickerService mediaPickerService})
      : _mediaPickerService = mediaPickerService,
        super(const InteriorDesignState());

  final MediaPickerService _mediaPickerService;

  void reset() => emit(const InteriorDesignState());

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
    emit(state.copyWith(clearAddedPhoto: true, clearExample: true));
  }

  void selectRoomType(RoomType roomType) {
    if (roomType != RoomType.other) {
      emit(state.copyWith(roomType: roomType, clearCustomRoomName: true));
      return;
    }
    emit(state.copyWith(roomType: roomType));
  }

  void setCustomRoomName(String name) {
    emit(state.copyWith(customRoomName: name));
  }

  void selectStyle(DesignStyle style) {
    if (style != DesignStyle.custom) {
      emit(state.copyWith(style: style, clearCustomPrompt: true));
      return;
    }
    emit(state.copyWith(style: style));
  }

  void setCustomPrompt(String prompt) {
    emit(state.copyWith(style: DesignStyle.custom, customPrompt: prompt));
  }

  void selectColorPalette(ColorPalette palette) {
    emit(state.copyWith(colorPalette: palette));
  }

  void next() {
    switch (state.step) {
      case InteriorStep.addPhoto:
        emit(state.copyWith(step: InteriorStep.roomType));
      case InteriorStep.roomType:
        emit(state.copyWith(step: InteriorStep.style));
      case InteriorStep.style:
        emit(state.copyWith(step: InteriorStep.colorPalette));
      case InteriorStep.colorPalette:
        startProcessing();
      case InteriorStep.processing:
      case InteriorStep.result:
      case InteriorStep.error:
        break;
    }
  }

  void back() {
    switch (state.step) {
      case InteriorStep.roomType:
        emit(state.copyWith(step: InteriorStep.addPhoto));
      case InteriorStep.style:
        emit(state.copyWith(step: InteriorStep.roomType));
      case InteriorStep.colorPalette:
        emit(state.copyWith(step: InteriorStep.style));
      case InteriorStep.addPhoto:
      case InteriorStep.processing:
      case InteriorStep.result:
      case InteriorStep.error:
        break;
    }
  }

  Future<void> startProcessing() async {
    emit(state.copyWith(step: InteriorStep.processing));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed && state.step == InteriorStep.processing) {
      emit(state.copyWith(step: InteriorStep.result));
    }
  }

  void setError() {
    emit(state.copyWith(step: InteriorStep.error));
  }

  void retry() => startProcessing();
}
