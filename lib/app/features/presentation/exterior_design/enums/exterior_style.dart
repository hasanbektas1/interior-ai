import 'package:interior_ai/app/common/enums/app_assets.dart';

enum ExteriorStyle {
  custom('Custom', AppAsset.exteriorCustomIllustration),
  artDeco('Art Deco', AppAsset.exteriorStyleArtDeco),
  brutalist('Brutalist', AppAsset.exteriorStyleBrutalist),
  chinese('Chinese', AppAsset.exteriorStyleChinese),
  cottage('Cottage', AppAsset.exteriorStyleCottage),
  farmHouse('Farm House', AppAsset.exteriorStyleFarmHouse),
  french('French', AppAsset.exteriorStyleFrench),
  gothic('Gothic', AppAsset.exteriorStyleGothic),
  italiante('Italiante', AppAsset.exteriorStyleItaliante),
  japanese('Japanese', AppAsset.exteriorStyleJapanese),
  mediterranean('Mediterranean', AppAsset.exteriorStyleMediterranean),
  midCentury('Mid Century', AppAsset.exteriorStyleMidCentury),
  middleEastern('Middle Eastern', AppAsset.exteriorStyleMiddleEastern),
  minimalistic('Minimalistic', AppAsset.exteriorStyleMinimalistic),
  modern('Modern', AppAsset.exteriorStyleModern),
  morocco('Morocco', AppAsset.exteriorStyleMorocco),
  spanish('Spanish', AppAsset.exteriorStyleSpanish),
  skiChalet('Ski Chalet', AppAsset.exteriorStyleSkiChalet);

  final String label;
  final AppAsset previewImage;
  const ExteriorStyle(this.label, this.previewImage);
}

extension ExteriorStyleX on ExteriorStyle {
  bool get isCustom => this == ExteriorStyle.custom;
}
