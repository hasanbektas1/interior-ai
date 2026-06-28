import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_state.dart';
import 'package:interior_ai/app/features/presentation/style_reference/enums/style_reference_step.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';

final class StyleReferenceCubit extends Cubit<StyleReferenceState> {
  StyleReferenceCubit({
    required MediaPickerService mediaPickerService,
    required CollectionCubit collectionCubit,
  })  : _mediaPickerService = mediaPickerService,
        _collectionCubit = collectionCubit,
        super(const StyleReferenceState());

  final MediaPickerService _mediaPickerService;
  final CollectionCubit _collectionCubit;

  void reset() => emit(const StyleReferenceState());

  void selectExample(int index) {
    if (state.step == StyleReferenceStep.yourPhoto) {
      emit(state.copyWith(photoIndex: index, clearPhotoPath: true));
      return;
    }
    emit(state.copyWith(refIndex: index, clearRefPath: true));
  }

  Future<void> pickPhotoFromCamera() async {
    final path = await _mediaPickerService.pickFromCamera();
    if (path == null || isClosed) return;
    _applyPickedPhoto(path);
  }

  Future<void> pickPhotoFromGallery() async {
    final path = await _mediaPickerService.pickFromGallery();
    if (path == null || isClosed) return;
    _applyPickedPhoto(path);
  }

  void _applyPickedPhoto(String path) {
    if (state.step == StyleReferenceStep.yourPhoto) {
      emit(state.copyWith(photoPath: path, clearPhotoIndex: true));
      return;
    }
    emit(state.copyWith(refPath: path, clearRefIndex: true));
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
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.styleReference,
      title: AppStrings.styleReferenceCollectionTitle,
      placeholderImagePath:
          state.photoSelectedPath ?? AppAsset.interiorResult.path,
      styleLabel: CollectionCategory.styleReference.label,
    );
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;
    await _collectionCubit.completeGenerating(id, AppAsset.interiorResult.path);
    if (state.step == StyleReferenceStep.processing) {
      emit(state.copyWith(step: StyleReferenceStep.result));
    }
  }

  void setError() => emit(state.copyWith(step: StyleReferenceStep.error));

  void retry() => startProcessing();
}
