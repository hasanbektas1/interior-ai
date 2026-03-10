import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_onboarding_assets.dart';

enum OnboardingSpace {
  bedroom,
  diningRoom,
  livingRoom,
  workspace,
  greySofa,
  armchair,
}

enum OnboardingStyle {
  modern,
  baroque,
  bohemian,
  rustic,
  vintage,
  luxury,
}

extension OnboardingSpaceX on OnboardingSpace {
  String get label => AppStrings.spaceTypes[index];

  AppOnboardingSelectImage get _selectImage => switch (this) {
        OnboardingSpace.bedroom => AppOnboardingSelectImage.bedroom,
        OnboardingSpace.diningRoom => AppOnboardingSelectImage.diningRoom,
        OnboardingSpace.livingRoom => AppOnboardingSelectImage.livingRoom,
        OnboardingSpace.workspace => AppOnboardingSelectImage.workspace,
        OnboardingSpace.greySofa => AppOnboardingSelectImage.greySofa,
        OnboardingSpace.armchair => AppOnboardingSelectImage.armchair,
      };

  AppOnboardingMiniImage get _miniImage => switch (this) {
        OnboardingSpace.bedroom => AppOnboardingMiniImage.bedroom,
        OnboardingSpace.diningRoom => AppOnboardingMiniImage.diningRoom,
        OnboardingSpace.livingRoom => AppOnboardingMiniImage.livingRoom,
        OnboardingSpace.workspace => AppOnboardingMiniImage.workspace,
        OnboardingSpace.greySofa => AppOnboardingMiniImage.greySofa,
        OnboardingSpace.armchair => AppOnboardingMiniImage.armchair,
      };

  String get selectAsset => _selectImage.path;

  String get miniAsset => _miniImage.path;
}

extension OnboardingStyleX on OnboardingStyle {
  String get label => AppStrings.styleTypes[index];

  AppOnboardingSelectImage get _selectImage => switch (this) {
        OnboardingStyle.modern => AppOnboardingSelectImage.modern,
        OnboardingStyle.baroque => AppOnboardingSelectImage.baroque,
        OnboardingStyle.bohemian => AppOnboardingSelectImage.bohemian,
        OnboardingStyle.rustic => AppOnboardingSelectImage.rustic,
        OnboardingStyle.vintage => AppOnboardingSelectImage.vintage,
        OnboardingStyle.luxury => AppOnboardingSelectImage.luxury,
      };

  String get selectAsset => _selectImage.path;
}

const Map<OnboardingSpace, int> _spaceResultVariantCount = {
  OnboardingSpace.bedroom: 5,
  OnboardingSpace.diningRoom: 6,
  OnboardingSpace.livingRoom: 6,
  OnboardingSpace.workspace: 5,
  OnboardingSpace.greySofa: 6,
  OnboardingSpace.armchair: 7,
};

extension OnboardingResultAssets on OnboardingSpace {
  String resultForStyle(OnboardingStyle style) {
    final count = _spaceResultVariantCount[this] ?? 1;

    final AppOnboardingResultSpaceImage spaceImage = switch (this) {
      OnboardingSpace.bedroom => AppOnboardingResultSpaceImage.bedroom,
      OnboardingSpace.diningRoom => AppOnboardingResultSpaceImage.diningRoom,
      OnboardingSpace.livingRoom => AppOnboardingResultSpaceImage.livingRoom,
      OnboardingSpace.workspace => AppOnboardingResultSpaceImage.workspace,
      OnboardingSpace.greySofa => AppOnboardingResultSpaceImage.greySofa,
      OnboardingSpace.armchair => AppOnboardingResultSpaceImage.armchair,
    };

    if (count <= 1) {
      return spaceImage.basePath();
    }

    final variantIndex = style.index % count;
    if (variantIndex == 0) {
      return spaceImage.basePath();
    }

    return spaceImage.variantPath(variantIndex);
  }
}

