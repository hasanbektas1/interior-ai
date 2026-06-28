import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_state.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/enums/replace_objects_step.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';

final class ReplaceObjectsCubit extends Cubit<ReplaceObjectsState> {
  ReplaceObjectsCubit({
    required MediaPickerService mediaPickerService,
    required CollectionCubit collectionCubit,
  })  : _mediaPickerService = mediaPickerService,
        _collectionCubit = collectionCubit,
        super(const ReplaceObjectsState());

  final MediaPickerService _mediaPickerService;
  final CollectionCubit _collectionCubit;

  void reset() => emit(const ReplaceObjectsState());

  void setPhoto(String path) => emit(state.copyWith(photoPath: path));

  Future<void> pickPhotoFromCamera() async {
    final path = await _mediaPickerService.pickFromCamera();
    if (path == null || isClosed) return;
    emit(state.copyWith(photoPath: path));
  }

  Future<void> pickPhotoFromGallery() async {
    final path = await _mediaPickerService.pickFromGallery();
    if (path == null || isClosed) return;
    emit(state.copyWith(photoPath: path));
  }

  void removePhoto() => emit(state.copyWith(clearPhoto: true));

  void setPrompt(String prompt) => emit(state.copyWith(prompt: prompt));

  void selectResult(int index) =>
      emit(state.copyWith(selectedResultIndex: index));

  Future<void> generate() async {
    emit(state.copyWith(
      step: ReplaceObjectsStep.processing,
      selectedResultIndex: 0,
    ));
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.replaceObject,
      title: AppStrings.replaceObjectCollectionTitle,
      placeholderImagePath: state.photoPath ?? state.selectedResult.path,
      styleLabel: CollectionCategory.replaceObject.label,
      prompt: state.prompt.trim().isEmpty ? null : state.prompt.trim(),
    );
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;
    await _collectionCubit.completeGenerating(id, state.selectedResult.path);
    if (state.step == ReplaceObjectsStep.processing) {
      emit(state.copyWith(step: ReplaceObjectsStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: ReplaceObjectsStep.error));

  void retry() => generate();
}
