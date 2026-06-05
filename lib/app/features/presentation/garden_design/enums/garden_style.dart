import 'package:interior_ai/app/common/enums/app_assets.dart';

enum GardenStyle {
  custom('Custom', AppAsset.gardenCustomIllustration),
  city('City', AppAsset.gardenStyleCity),
  modern('Modern', AppAsset.gardenStyleModern),
  contemporary('Contemporary', AppAsset.gardenStyleContemporary),
  small('Small', AppAsset.gardenStyleSmall),
  apartment('Apartment', AppAsset.gardenStyleApartment),
  luxury('Luxury', AppAsset.gardenStyleLuxury),
  vegetable('Vegetable', AppAsset.gardenStyleVegetable),
  mediterranean('Mediterranean', AppAsset.gardenStyleMediterranean),
  beach('Beach', AppAsset.gardenStyleBeach),
  lowBudget('Low Budget', AppAsset.gardenStyleLowBudget),
  wedding('Wedding', AppAsset.gardenStyleWedding),
  rural('Rural', AppAsset.gardenStyleRural),
  restaurant('Restaurant', AppAsset.gardenStyleRestaurant),
  informal('Informal', AppAsset.gardenStyleInformal),
  american('American', AppAsset.gardenStyleAmerican),
  english('English', AppAsset.gardenStyleEnglish);

  final String label;
  final AppAsset previewImage;
  const GardenStyle(this.label, this.previewImage);
}

extension GardenStyleX on GardenStyle {
  bool get isCustom => this == GardenStyle.custom;
}
