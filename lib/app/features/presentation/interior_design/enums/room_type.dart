import 'package:interior_ai/app/common/enums/app_assets.dart';

enum RoomType {
  livingRoom('Living Room', AppAsset.roomLivingRoom),
  bedroom('Bedroom', AppAsset.roomBedroom),
  bathroom('Bathroom', AppAsset.roomBathroom),
  kitchen('Kitchen', AppAsset.roomKitchen),
  studyRoom('Study Room', AppAsset.roomStudyRoom),
  gamingRoom('Gaming Room', AppAsset.roomGamingRoom),
  diningRoom('Dining Room', AppAsset.roomDiningRoom),
  garden('Garden', AppAsset.roomGarden),
  restaurant('Restaurant', AppAsset.roomRestaurant),
  coffeeShop('Coffee Shop', AppAsset.roomCoffeeShop),
  homeOffice('Home Office', AppAsset.roomHomeOffice),
  office('Office', AppAsset.roomOffice),
  hall('Hall', AppAsset.roomHall),
  deck('Deck', AppAsset.roomDeck),
  other('Other', AppAsset.roomOther);

  final String label;
  final AppAsset icon;
  const RoomType(this.label, this.icon);
}
