import 'package:interior_ai/app/common/enums/app_assets.dart';

enum DesignStyle {
  custom('Custom'),
  minimalistic('Minimalistic'),
  modern('Modern'),
  rustic('Rustic'),
  bohemian('Bohemian'),
  vintage('Vintage'),
  luxury('Luxury'),
  baroque('Baroque'),
  mediterranean('Mediterranean'),
  cyberpunk('Cyberpunk'),
  japandi('Japandi'),
  soho('Soho'),
  tropical('Tropical'),
  gamer('Gamer'),
  cozy('Cozy'),
  coastal('Coastal'),
  airbnb('Airbnb'),
  disco('Disco'),
  ancient('Ancient'),
  biophilic('Biophilic'),
  gothic('Gothic'),
  cottagecore('Cottagecore'),
  medieval('Medieval'),
  eighties("80's"),
  wood('Wood'),
  chocolate('Chocolate'),
  creepy('Creepy'),
  cartoon('Cartoon'),
  rainbow('Rainbow'),
  skiChalet('Ski Chalet');

  final String label;
  const DesignStyle(this.label);
}

const List<AppAsset> _placeholderStyleImages = [
  AppAsset.onboardingSelectBedroom,
  AppAsset.onboardingSelectLivingRoom,
  AppAsset.onboardingSelectDiningRoom,
  AppAsset.onboardingSelectWorkspace,
  AppAsset.onboardingSelectGreySofa,
  AppAsset.onboardingSelectArmchair,
];

extension DesignStyleX on DesignStyle {
  bool get isCustom => this == DesignStyle.custom;

  AppAsset get previewImage =>
      _placeholderStyleImages[index % _placeholderStyleImages.length];
}
