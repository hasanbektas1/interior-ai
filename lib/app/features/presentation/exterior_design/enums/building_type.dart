import 'package:interior_ai/app/common/enums/app_assets.dart';

enum BuildingType {
  apartment('Apartment', AppAsset.exteriorBuildingApartment),
  house('House', AppAsset.exteriorBuildingHouse),
  office('Office Building', AppAsset.exteriorBuildingOffice),
  residental('Residental', AppAsset.exteriorBuildingResidental),
  retail('Retail', AppAsset.exteriorBuildingRetail),
  villa('Villa', AppAsset.exteriorBuildingVilla);

  final String label;
  final AppAsset image;
  const BuildingType(this.label, this.image);
}
