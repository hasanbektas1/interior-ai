import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/data/repositories/image_generation_repository.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_state.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/enums/replace_objects_step.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/paywall_view.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';
import 'package:interior_ai/core/helpers/navigation_helper/navigation_helper.dart';

final class ReplaceObjectsCubit extends Cubit<ReplaceObjectsState> {
  ReplaceObjectsCubit({
    required MediaPickerService mediaPickerService,
    required CollectionCubit collectionCubit,
    required ImageGenerationRepository imageRepository,
    required CreditsCubit creditsCubit,
  })  : _mediaPickerService = mediaPickerService,
        _collectionCubit = collectionCubit,
        _imageRepository = imageRepository,
        _creditsCubit = creditsCubit,
        super(const ReplaceObjectsState());

  final MediaPickerService _mediaPickerService;
  final CollectionCubit _collectionCubit;
  final ImageGenerationRepository _imageRepository;
  final CreditsCubit _creditsCubit;

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
    final source = state.photoPath;
    if (source == null) {
      emit(state.copyWith(step: ReplaceObjectsStep.error));
      return;
    }
    emit(state.copyWith(step: ReplaceObjectsStep.processing));
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.replaceObject,
      title: AppStrings.replaceObjectCollectionTitle,
      placeholderImagePath: source,
      styleLabel: CollectionCategory.replaceObject.label,
      prompt: state.prompt.trim().isEmpty ? null : state.prompt.trim(),
    );

    final result = await _imageRepository.generate(
      prompt: '${state.prompt.trim()}. Keep the rest of the room, its layout, '
          'lighting, and camera perspective unchanged. Photorealistic, high '
          'detail.',
      sourceImagePath: source,
    );
    if (isClosed) return;

    final resultPath = result.data;
    if (result.success && resultPath != null) {
      await _collectionCubit.completeGenerating(id, resultPath);
      await _creditsCubit.refresh();
      if (state.step == ReplaceObjectsStep.processing) {
        emit(state.copyWith(
          step: ReplaceObjectsStep.result,
          resultImagePath: resultPath,
        ));
      }
      return;
    }

    await _collectionCubit.deleteItem(id);

    if (result.message == kInsufficientCreditsError) {
      if (state.step == ReplaceObjectsStep.processing) {
        emit(state.copyWith(step: ReplaceObjectsStep.editor));
      }
      Navigation.push(page: const PaywallView());
      return;
    }

    if (state.step == ReplaceObjectsStep.processing) {
      emit(state.copyWith(step: ReplaceObjectsStep.error));
    }
  }

  void setError() => emit(state.copyWith(step: ReplaceObjectsStep.error));

  void retry() => generate();
}
