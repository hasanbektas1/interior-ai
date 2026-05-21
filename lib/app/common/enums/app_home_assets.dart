enum AppHomeImage {
  interiorDesign('home_interior_design_png'),
  exteriorDesign('home_exterior_design_png'),
  replaceObjects('home_replace_objects_png'),
  floorRestyle('home_floor_restyle_png'),
  gardenDesign('home_garden_design_png'),
  styleReference('home_style_reference_png');

  const AppHomeImage(this.filename);

  final String filename;
}

extension AppHomeImageExtension on AppHomeImage {
  String get path => 'assets/png/home/$filename.png';
}

enum AppHomeIcon {
  premium('home_premium_icon_svg'),
  settings('home_settings_svg');

  const AppHomeIcon(this.filename);

  final String filename;
}

extension AppHomeIconExtension on AppHomeIcon {
  String get path => 'assets/svg/home/$filename.svg';
}
