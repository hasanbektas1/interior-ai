import 'package:interior_ai/app/common/enums/app_assets.dart';

enum FloorMaterial {
  custom('Custom', AppAsset.floorCustomIllustration),
  classicParquet('Classic Parquet', AppAsset.floorMaterialClassicParquet),
  rusticWood('Rustic Wood', AppAsset.floorMaterialRusticWood),
  lightOak('Light Oak', AppAsset.floorMaterialLightOak),
  darkWalnut('Dark walnut', AppAsset.floorMaterialDarkWalnut),
  glossyWhiteTile('Glossy White Tile', AppAsset.floorMaterialGlossyWhiteTile),
  patternedTile('Patterned Tile', AppAsset.floorMaterialPatternedTile),
  whiteMarble('White Marble', AppAsset.floorMaterialWhiteMarble),
  blackMarble('Black Marble', AppAsset.floorMaterialBlackMarble),
  carpet('Carpet', AppAsset.floorMaterialCarpet);

  final String label;
  final AppAsset image;
  const FloorMaterial(this.label, this.image);
}

extension FloorMaterialX on FloorMaterial {
  bool get isCustom => this == FloorMaterial.custom;
}
