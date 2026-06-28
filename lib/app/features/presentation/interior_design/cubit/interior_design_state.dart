import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/color_palette.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/design_style.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/interior_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';

const List<AppAsset> kExamplePhotos = [
  AppAsset.onboardingSelectBedroom,
  AppAsset.onboardingSelectWorkspace,
  AppAsset.onboardingSelectLivingRoom,
  AppAsset.onboardingSelectDiningRoom,
  AppAsset.onboardingSelectArmchair,
  AppAsset.onboardingSelectGreySofa,
];

final class InteriorDesignState extends Equatable {
  final InteriorStep step;
  final int? exampleIndex;
  final String? addedPhotoPath;
  final RoomType? roomType;
  final String? customRoomName;
  final DesignStyle? style;
  final String? customPrompt;
  final ColorPalette? colorPalette;
  final String? resultImagePath;

  const InteriorDesignState({
    this.step = InteriorStep.addPhoto,
    this.exampleIndex,
    this.addedPhotoPath,
    this.roomType,
    this.customRoomName,
    this.style,
    this.customPrompt,
    this.colorPalette,
    this.resultImagePath,
  });

  InteriorDesignState copyWith({
    InteriorStep? step,
    int? exampleIndex,
    String? addedPhotoPath,
    RoomType? roomType,
    String? customRoomName,
    DesignStyle? style,
    String? customPrompt,
    ColorPalette? colorPalette,
    String? resultImagePath,
    bool clearExample = false,
    bool clearAddedPhoto = false,
    bool clearCustomRoomName = false,
    bool clearCustomPrompt = false,
  }) {
    return InteriorDesignState(
      step: step ?? this.step,
      exampleIndex: clearExample ? null : (exampleIndex ?? this.exampleIndex),
      addedPhotoPath:
          clearAddedPhoto ? null : (addedPhotoPath ?? this.addedPhotoPath),
      roomType: roomType ?? this.roomType,
      customRoomName:
          clearCustomRoomName ? null : (customRoomName ?? this.customRoomName),
      style: style ?? this.style,
      customPrompt:
          clearCustomPrompt ? null : (customPrompt ?? this.customPrompt),
      colorPalette: colorPalette ?? this.colorPalette,
      resultImagePath: resultImagePath ?? this.resultImagePath,
    );
  }

  bool get hasPhoto => addedPhotoPath != null || exampleIndex != null;

  bool get isCustomStyle => style == DesignStyle.custom;

  String get styleLabel => style?.label ?? '';

  String get roomDisplayValue {
    final type = roomType;
    if (type == null) return '';
    if (type == RoomType.other) {
      return (customRoomName?.trim().isNotEmpty ?? false)
          ? customRoomName!
          : type.label;
    }
    return type.label;
  }

  String? get selectedPhotoPath {
    if (addedPhotoPath != null) return addedPhotoPath;
    if (exampleIndex != null) return kExamplePhotos[exampleIndex!].path;
    return null;
  }

  bool get canContinue => switch (step) {
        InteriorStep.addPhoto => hasPhoto,
        InteriorStep.roomType => roomType != null &&
            (roomType != RoomType.other ||
                (customRoomName?.trim().isNotEmpty ?? false)),
        InteriorStep.style => style != null &&
            (style != DesignStyle.custom ||
                (customPrompt?.trim().isNotEmpty ?? false)),
        InteriorStep.colorPalette => colorPalette != null,
        InteriorStep.processing => false,
        InteriorStep.result => false,
        InteriorStep.error => false,
      };

  @override
  List<Object?> get props => [
        step,
        exampleIndex,
        addedPhotoPath,
        roomType,
        customRoomName,
        style,
        customPrompt,
        colorPalette,
        resultImagePath,
      ];
}
