import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_state.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_material.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_step.dart';

final class FloorRestyleCubit extends Cubit<FloorRestyleState> {
  FloorRestyleCubit() : super(const FloorRestyleState());

  String get _samplePhoto => AppAsset.floorResult.path;

  void reset() => emit(const FloorRestyleState());

  void selectExample(int index) {
    emit(state.copyWith(exampleIndex: index, clearAddedPhoto: true));
  }

  void addSamplePhoto() {
    emit(state.copyWith(addedPhotoPath: _samplePhoto, clearExample: true));
  }

  void removePhoto() {
    emit(state.copyWith(clearExample: true, clearAddedPhoto: true));
  }

  void setPainted(bool painted) {
    if (state.hasPainted == painted) return;
    emit(state.copyWith(hasPainted: painted));
  }

  void selectMaterial(FloorMaterial material) {
    if (material != FloorMaterial.custom) {
      emit(state.copyWith(material: material, clearCustomPrompt: true));
      return;
    }
    emit(state.copyWith(material: material));
  }

  void setCustomPrompt(String prompt) {
    emit(state.copyWith(material: FloorMaterial.custom, customPrompt: prompt));
  }

  void next() {
    switch (state.step) {
      case FloorStep.addPhoto:
        emit(state.copyWith(step: FloorStep.paint));
      case FloorStep.paint:
        emit(state.copyWith(step: FloorStep.material));
      case FloorStep.material:
        startProcessing();
      case FloorStep.processing:
      case FloorStep.result:
      case FloorStep.error:
        break;
    }
  }

  void back() {
    switch (state.step) {
      case FloorStep.paint:
        emit(state.copyWith(step: FloorStep.addPhoto));
      case FloorStep.material:
        emit(state.copyWith(step: FloorStep.paint));
      case FloorStep.addPhoto:
      case FloorStep.processing:
      case FloorStep.result:
      case FloorStep.error:
        break;
    }
  }

  Future<void> startProcessing() async {
    emit(state.copyWith(step: FloorStep.processing));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed && state.step == FloorStep.processing) {
      emit(state.copyWith(step: FloorStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: FloorStep.error));

  void retry() => startProcessing();
}
