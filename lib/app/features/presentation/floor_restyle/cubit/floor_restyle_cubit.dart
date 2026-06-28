import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_state.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_material.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_step.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';

final class FloorRestyleCubit extends Cubit<FloorRestyleState> {
  FloorRestyleCubit({
    required MediaPickerService mediaPickerService,
    required CollectionCubit collectionCubit,
  })  : _mediaPickerService = mediaPickerService,
        _collectionCubit = collectionCubit,
        super(const FloorRestyleState());

  final MediaPickerService _mediaPickerService;
  final CollectionCubit _collectionCubit;

  void reset() => emit(const FloorRestyleState());

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
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.floorRestyle,
      title: AppStrings.floorCollectionTitle,
      placeholderImagePath:
          state.selectedPhotoPath ?? AppAsset.floorResult.path,
      styleLabel: state.material?.label ?? '',
      prompt: state.material == FloorMaterial.custom ? state.customPrompt : null,
    );
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;
    await _collectionCubit.completeGenerating(id, AppAsset.floorResult.path);
    if (state.step == FloorStep.processing) {
      emit(state.copyWith(step: FloorStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: FloorStep.error));

  void retry() => startProcessing();
}
