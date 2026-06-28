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

extension DesignStyleX on DesignStyle {
  bool get isCustom => this == DesignStyle.custom;

  AppAsset get previewImage => switch (this) {
        DesignStyle.custom => AppAsset.styleCustom,
        DesignStyle.minimalistic => AppAsset.styleMinimalistic,
        DesignStyle.modern => AppAsset.styleModern,
        DesignStyle.rustic => AppAsset.styleRustic,
        DesignStyle.bohemian => AppAsset.styleBohemian,
        DesignStyle.vintage => AppAsset.styleVintage,
        DesignStyle.luxury => AppAsset.styleLuxury,
        DesignStyle.baroque => AppAsset.styleBaroque,
        DesignStyle.mediterranean => AppAsset.styleMediterranean,
        DesignStyle.cyberpunk => AppAsset.styleCyberpunk,
        DesignStyle.japandi => AppAsset.styleJapandi,
        DesignStyle.soho => AppAsset.styleSoho,
        DesignStyle.tropical => AppAsset.styleTropical,
        DesignStyle.gamer => AppAsset.styleGamer,
        DesignStyle.cozy => AppAsset.styleCozy,
        DesignStyle.coastal => AppAsset.styleCoastal,
        DesignStyle.airbnb => AppAsset.styleAirbnb,
        DesignStyle.disco => AppAsset.styleDisco,
        DesignStyle.ancient => AppAsset.styleAncient,
        DesignStyle.biophilic => AppAsset.styleBiophilic,
        DesignStyle.gothic => AppAsset.styleGothic,
        DesignStyle.cottagecore => AppAsset.styleCottagecore,
        DesignStyle.medieval => AppAsset.styleMedieval,
        DesignStyle.eighties => AppAsset.styleEighties,
        DesignStyle.wood => AppAsset.styleWood,
        DesignStyle.chocolate => AppAsset.styleChocolate,
        DesignStyle.creepy => AppAsset.styleCreepy,
        DesignStyle.cartoon => AppAsset.styleCartoon,
        DesignStyle.rainbow => AppAsset.styleRainbow,
        DesignStyle.skiChalet => AppAsset.styleSkiChalet,
      };
}
