enum AppOnboardingSelectImage {
  // Spaces
  bedroom('select_bedroom_png'),
  diningRoom('select_dining_room_png'),
  livingRoom('select_living_room_png'),
  workspace('select_workspace_png'),
  greySofa('select_grey_sofa_png'),
  armchair('select_armchair_png'),

  // Styles
  modern('select_modern_png'),
  baroque('select_baroque_png'),
  bohemian('select_bohemian_png'),
  rustic('select_rustic_png'),
  vintage('select_vintage_png'),
  luxury('select_luxury_png');

  final String filename;
  const AppOnboardingSelectImage(this.filename);
}

extension AppOnboardingSelectImageExtension on AppOnboardingSelectImage {
  String get path => 'assets/onboarding/$filename.png';
}

enum AppOnboardingMiniImage {
  bedroom('mini_bedroom_png'),
  diningRoom('mini_dining_room_png'),
  livingRoom('mini_living_room_png'),
  workspace('mini_workspace_png'),
  greySofa('mini_grey_sofa_png'),
  armchair('mini_armchair_png');

  final String filename;
  const AppOnboardingMiniImage(this.filename);
}

extension AppOnboardingMiniImageExtension on AppOnboardingMiniImage {
  String get path => 'assets/onboarding_mini/$filename.png';
}

enum AppOnboardingResultSpaceImage {
  bedroom('result_bedroom'),
  diningRoom('result_dining_room'),
  livingRoom('result_living_room'),
  workspace('result_workspace'),
  greySofa('result_grey_sofa'),
  armchair('result_armchair');

  final String filenamePrefix;
  const AppOnboardingResultSpaceImage(this.filenamePrefix);
}

extension AppOnboardingResultSpaceImageExtension on AppOnboardingResultSpaceImage {
  String basePath() => 'assets/onboarding_result/${filenamePrefix}_png.png';

  String variantPath(int variantIndex) {
    if (variantIndex <= 0) return basePath();
    return 'assets/onboarding_result/${filenamePrefix}_${variantIndex + 1}_png.png';
  }
}


