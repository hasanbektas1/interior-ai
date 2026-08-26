import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';

enum OnboardingSpace {
  bedroom,
  diningRoom,
  livingRoom,
  workspace,
  greySofa,
  armchair,
}

enum OnboardingStyle { modern, baroque, bohemian, rustic, vintage, luxury }

extension OnboardingSpaceX on OnboardingSpace {
  String get label => AppStrings.onboardingSpaceLabels[index];

  AppAsset get _selectImage => switch (this) {
    OnboardingSpace.bedroom => AppAsset.onboardingSelectBedroom,
    OnboardingSpace.diningRoom => AppAsset.onboardingSelectDiningRoom,
    OnboardingSpace.livingRoom => AppAsset.onboardingSelectLivingRoom,
    OnboardingSpace.workspace => AppAsset.onboardingSelectWorkspace,
    OnboardingSpace.greySofa => AppAsset.onboardingSelectGreySofa,
    OnboardingSpace.armchair => AppAsset.onboardingSelectArmchair,
  };

  AppAsset get _miniImage => switch (this) {
    OnboardingSpace.bedroom => AppAsset.onboardingMiniBedroom,
    OnboardingSpace.diningRoom => AppAsset.onboardingMiniDiningRoom,
    OnboardingSpace.livingRoom => AppAsset.onboardingMiniLivingRoom,
    OnboardingSpace.workspace => AppAsset.onboardingMiniWorkspace,
    OnboardingSpace.greySofa => AppAsset.onboardingMiniGreySofa,
    OnboardingSpace.armchair => AppAsset.onboardingMiniArmchair,
  };

  String get selectAsset => _selectImage.path;

  String get miniAsset => _miniImage.path;
}

extension OnboardingStyleX on OnboardingStyle {
  String get label => AppStrings.onboardingStyleLabels[index];

  AppAsset get _selectImage => switch (this) {
    OnboardingStyle.modern => AppAsset.onboardingSelectModern,
    OnboardingStyle.baroque => AppAsset.onboardingSelectBaroque,
    OnboardingStyle.bohemian => AppAsset.onboardingSelectBohemian,
    OnboardingStyle.rustic => AppAsset.onboardingSelectRustic,
    OnboardingStyle.vintage => AppAsset.onboardingSelectVintage,
    OnboardingStyle.luxury => AppAsset.onboardingSelectLuxury,
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
