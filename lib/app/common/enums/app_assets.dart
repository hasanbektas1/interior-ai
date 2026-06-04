enum AppAsset {
  // HOME
  homeInteriorDesign('assets/png/home/home_interior_design_png.png'),
  homeExteriorDesign('assets/png/home/home_exterior_design_png.png'),
  homeReplaceObjects('assets/png/home/home_replace_objects_png.png'),
  homeFloorRestyle('assets/png/home/home_floor_restyle_png.png'),
  homeGardenDesign('assets/png/home/home_garden_design_png.png'),
  homeStyleReference('assets/png/home/home_style_reference_png.png'),
  homePremiumIcon('assets/svg/home/home_premium_icon_svg.svg'),
  homeSettingsIcon('assets/svg/home/home_settings_svg.svg'),

  // ONBOARDING SELECT
  onboardingSelectBedroom('assets/png/onboarding/select_bedroom_png.png'),
  onboardingSelectDiningRoom('assets/png/onboarding/select_dining_room_png.png'),
  onboardingSelectLivingRoom('assets/png/onboarding/select_living_room_png.png'),
  onboardingSelectWorkspace('assets/png/onboarding/select_workspace_png.png'),
  onboardingSelectGreySofa('assets/png/onboarding/select_grey_sofa_png.png'),
  onboardingSelectArmchair('assets/png/onboarding/select_armchair_png.png'),
  onboardingSelectModern('assets/png/onboarding/select_modern_png.png'),
  onboardingSelectBaroque('assets/png/onboarding/select_baroque_png.png'),
  onboardingSelectBohemian('assets/png/onboarding/select_bohemian_png.png'),
  onboardingSelectRustic('assets/png/onboarding/select_rustic_png.png'),
  onboardingSelectVintage('assets/png/onboarding/select_vintage_png.png'),
  onboardingSelectLuxury('assets/png/onboarding/select_luxury_png.png'),

  // ONBOARDING MINI
  onboardingMiniBedroom('assets/png/onboarding_mini/mini_bedroom_png.png'),
  onboardingMiniDiningRoom('assets/png/onboarding_mini/mini_dining_room_png.png'),
  onboardingMiniLivingRoom('assets/png/onboarding_mini/mini_living_room_png.png'),
  onboardingMiniWorkspace('assets/png/onboarding_mini/mini_workspace_png.png'),
  onboardingMiniGreySofa('assets/png/onboarding_mini/mini_grey_sofa_png.png'),
  onboardingMiniArmchair('assets/png/onboarding_mini/mini_armchair_png.png'),

  // PAYWALL
  paywallBackground('assets/png/paywall/paywall_png3x.png'),

  // SETTINGS
  settingsPremiumBanner('assets/png/settings/settings_content.png'),

  // INTERIOR DESIGN ROOM ICONS
  roomLivingRoom('assets/svg/interior_design/living_room_svg.svg'),
  roomBedroom('assets/svg/interior_design/bedroom_svg.svg'),
  roomBathroom('assets/svg/interior_design/bathroom_svg.svg'),
  roomKitchen('assets/svg/interior_design/kitchen_svg.svg'),
  roomStudyRoom('assets/svg/interior_design/study_room_svg.svg'),
  roomGamingRoom('assets/svg/interior_design/gaming_room_svg.svg'),
  roomDiningRoom('assets/svg/interior_design/dining_room.svg'),
  roomGarden('assets/svg/interior_design/garden_svg.svg'),
  roomRestaurant('assets/svg/interior_design/restaurant_svg.svg'),
  roomCoffeeShop('assets/svg/interior_design/coffee_shop_svg.svg'),
  roomHomeOffice('assets/svg/interior_design/home_office_svg.svg'),
  roomOffice('assets/svg/interior_design/office_svg.svg'),
  roomHall('assets/svg/interior_design/hall_svg.svg'),
  roomDeck('assets/svg/interior_design/deck_svg.svg'),
  roomOther('assets/svg/interior_design/other_svg.svg'),

  // INTERIOR DESIGN RESULT
  interiorResult('assets/png/interrior_design/interrior_ai_result_png.png');

  final String path;
  const AppAsset(this.path);
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
  String basePath() => 'assets/png/onboarding_result/${filenamePrefix}_png.png';

  String variantPath(int variantIndex) {
    if (variantIndex <= 0) return basePath();
    return 'assets/png/onboarding_result/${filenamePrefix}_${variantIndex + 1}_png.png';
  }
}
