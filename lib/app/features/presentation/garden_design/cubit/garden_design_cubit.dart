import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/data/repositories/image_generation_repository.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_state.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_step.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_style.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/paywall_view.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';
import 'package:interior_ai/core/helpers/navigation_helper/navigation_helper.dart';

final class GardenDesignCubit extends Cubit<GardenDesignState> {
  GardenDesignCubit({
    required MediaPickerService mediaPickerService,
    required CollectionCubit collectionCubit,
    required ImageGenerationRepository imageRepository,
    required CreditsCubit creditsCubit,
  })  : _mediaPickerService = mediaPickerService,
        _collectionCubit = collectionCubit,
        _imageRepository = imageRepository,
        _creditsCubit = creditsCubit,
        super(const GardenDesignState());

  final MediaPickerService _mediaPickerService;
  final CollectionCubit _collectionCubit;
  final ImageGenerationRepository _imageRepository;
  final CreditsCubit _creditsCubit;

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
    final source = state.selectedPhotoPath;
    if (source == null) {
      emit(state.copyWith(step: GardenStep.error));
      return;
    }
    emit(state.copyWith(step: GardenStep.processing));
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.gardenDesign,
      title: AppStrings.gardenCollectionTitle,
      placeholderImagePath: source,
      styleLabel: state.style?.label ?? '',
      prompt: state.style == GardenStyle.custom ? state.customPrompt : null,
    );

    final result = await _imageRepository.generate(
      prompt: _buildPrompt(),
      sourceImagePath: source,
    );
    if (isClosed) return;

    final resultPath = result.data;
    if (result.success && resultPath != null) {
      await _collectionCubit.completeGenerating(id, resultPath);
      await _creditsCubit.refresh();
      if (state.step == GardenStep.processing) {
        emit(state.copyWith(
          step: GardenStep.result,
          resultImagePath: resultPath,
        ));
      }
      return;
    }

    await _collectionCubit.deleteItem(id);

    if (result.message == kInsufficientCreditsError) {
      if (state.step == GardenStep.processing) {
        emit(state.copyWith(step: GardenStep.style));
      }
      Navigation.push(page: const PaywallView());
      return;
    }

    if (state.step == GardenStep.processing) {
      emit(state.copyWith(step: GardenStep.error));
    }
  }

  String _buildPrompt() {
    if (state.style == GardenStyle.custom &&
        (state.customPrompt?.trim().isNotEmpty ?? false)) {
      return 'Redesign this garden / outdoor space. '
          '${state.customPrompt!.trim()}. Keep the original layout, boundaries, '
          'and camera perspective. Photorealistic, high detail.';
    }
    return 'Redesign this garden / outdoor space in ${state.style?.label ?? ''} '
        'style. Keep the original layout, boundaries, and camera perspective. '
        'Photorealistic landscaping, high detail.';
  }

  void setError() => emit(state.copyWith(step: GardenStep.error));

  void retry() => startProcessing();
}
