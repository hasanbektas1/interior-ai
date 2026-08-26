import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/data/repositories/image_generation_repository.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/paywall_view.dart';
import 'package:interior_ai/core/helpers/media_picker_service.dart';
import 'package:interior_ai/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/color_palette.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/design_style.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/interior_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';

final class InteriorDesignCubit extends Cubit<InteriorDesignState> {
  InteriorDesignCubit({
    required MediaPickerService mediaPickerService,
    required CollectionCubit collectionCubit,
    required ImageGenerationRepository imageRepository,
    required CreditsCubit creditsCubit,
  }) : _mediaPickerService = mediaPickerService,
       _collectionCubit = collectionCubit,
       _imageRepository = imageRepository,
       _creditsCubit = creditsCubit,
       super(const InteriorDesignState());

  final MediaPickerService _mediaPickerService;
  final CollectionCubit _collectionCubit;
  final ImageGenerationRepository _imageRepository;
  final CreditsCubit _creditsCubit;

  void reset() => emit(const InteriorDesignState());

  /// Removes the just-generated result from the collection (result screen
  /// "Delete" action).
  Future<void> deleteCurrentResult() async {
    final path = state.resultImagePath;
    if (path != null && path.isNotEmpty) {
      await _collectionCubit.deleteByImagePath(path);
    }
  }

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
    if (state.step == InteriorStep.processing) return; // guard double-tap
    final source = state.selectedPhotoPath;
    if (source == null) {
      emit(state.copyWith(step: InteriorStep.error));
      return;
    }
    emit(state.copyWith(step: InteriorStep.processing));
    final id = await _collectionCubit.startGenerating(
      category: CollectionCategory.interiorDesign,
      title: AppStrings.interiorCollectionTitle,
      placeholderImagePath: source,
      styleLabel: state.styleLabel,
      roomType: state.roomType,
      prompt: state.isCustomStyle ? state.customPrompt : null,
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
      if (state.step == InteriorStep.processing) {
        emit(
          state.copyWith(
            step: InteriorStep.result,
            resultImagePath: resultPath,
          ),
        );
      }
      return;
    }

    await _collectionCubit.deleteItem(id);

    // Out of credits: send the user back a step and open the paywall.
    if (result.message == kInsufficientCreditsError) {
      // Only surface the paywall if the user is still waiting in this flow.
      if (state.step == InteriorStep.processing) {
        emit(state.copyWith(step: InteriorStep.colorPalette));
        Navigation.push(page: const PaywallView());
      }
      return;
    }

    if (state.step == InteriorStep.processing) {
      emit(state.copyWith(step: InteriorStep.error));
    }
  }

  String _buildPrompt() {
    if (state.isCustomStyle &&
        (state.customPrompt?.trim().isNotEmpty ?? false)) {
      return 'Redesign this ${state.roomDisplayValue} interior. '
          '${state.customPrompt!.trim()}. Keep the original room architecture, '
          'windows, and camera perspective. Photorealistic, high detail.';
    }
    final palette = state.colorPalette?.label;
    return 'Redesign this ${state.roomDisplayValue} interior in '
        '${state.styleLabel} style'
        '${palette != null ? ' with a $palette color palette' : ''}. '
        'Keep the original room architecture, layout, windows, and camera '
        'perspective. Photorealistic interior design, high detail.';
  }

  void setError() {
    emit(state.copyWith(step: InteriorStep.error));
  }

  void retry() => startProcessing();
}
