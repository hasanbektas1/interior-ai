import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/data/repositories/image_generation_repository.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_state.dart';
import 'package:interior_ai/app/features/presentation/style_reference/enums/style_reference_step.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/paywall_view.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';
import 'package:interior_ai/core/helpers/navigation_helper/navigation_helper.dart';

final class StyleReferenceCubit extends Cubit<StyleReferenceState> {
  StyleReferenceCubit({
    required MediaPickerService mediaPickerService,
    required CollectionCubit collectionCubit,
    required ImageGenerationRepository imageRepository,
    required CreditsCubit creditsCubit,
  }) : _mediaPickerService = mediaPickerService,
       _collectionCubit = collectionCubit,
       _imageRepository = imageRepository,
       _creditsCubit = creditsCubit,
       super(const StyleReferenceState());

  final MediaPickerService _mediaPickerService;
  final CollectionCubit _collectionCubit;
  final ImageGenerationRepository _imageRepository;
  final CreditsCubit _creditsCubit;

  void reset() => emit(const StyleReferenceState());

  Future<void> deleteCurrentResult() async {
    final path = state.resultImagePath;
    if (path != null && path.isNotEmpty) {
      await _collectionCubit.deleteByImagePath(path);
    }
  }

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
    if (state.step == StyleReferenceStep.processing) return; // guard double-tap
    final source = state.photoSelectedPath;
    final reference = state.refSelectedPath;
    if (source == null || reference == null) {
      emit(state.copyWith(step: StyleReferenceStep.error));
      return;
    }
    emit(state.copyWith(step: StyleReferenceStep.processing));
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.styleReference,
      title: AppStrings.styleReferenceCollectionTitle,
      placeholderImagePath: source,
      styleLabel: CollectionCategory.styleReference.label,
    );

    final result = await _imageRepository.generate(
      prompt:
          'Restyle the first image so it adopts the interior style, '
          'materials, colors, and mood of the second (reference) image. Keep '
          "the first image's room architecture, layout, windows, and camera "
          'perspective unchanged. Photorealistic, high detail.',
      sourceImagePath: source,
      referenceImagePath: reference,
    );
    if (isClosed) return;

    final resultPath = result.data;
    if (result.success && resultPath != null) {
      await _collectionCubit.completeGenerating(id, resultPath);
      await _creditsCubit.refresh();
      if (state.step == StyleReferenceStep.processing) {
        emit(
          state.copyWith(
            step: StyleReferenceStep.result,
            resultImagePath: resultPath,
          ),
        );
      }
      return;
    }

    await _collectionCubit.deleteItem(id);

    if (result.message == kInsufficientCreditsError) {
      if (state.step == StyleReferenceStep.processing) {
        emit(state.copyWith(step: StyleReferenceStep.referencePhoto));
        Navigation.push(page: const PaywallView());
      }
      return;
    }

    if (state.step == StyleReferenceStep.processing) {
      emit(state.copyWith(step: StyleReferenceStep.error));
    }
  }

  void setError() => emit(state.copyWith(step: StyleReferenceStep.error));

  void retry() => startProcessing();
}
