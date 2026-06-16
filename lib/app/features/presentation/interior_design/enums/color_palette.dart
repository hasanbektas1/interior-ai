import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';

enum ColorPalette {
  random('Random', AppAsset.paletteRandom, [
    Color(0xff2E6BE6),
    Color(0xff4FB0C6),
    Color(0xff6CC551),
    Color(0xffF2C14E),
    Color(0xffE8743B),
  ]),
  solarHorizon('Solar Horizon', AppAsset.paletteSolarHorizon, [
    Color(0xffBFE3F0),
    Color(0xff12324F),
    Color(0xff2C7DA0),
    Color(0xffF6C453),
    Color(0xffE8833A),
  ]),
  blushTwilight('Blush Twilight', AppAsset.paletteBlushTwilight, [
    Color(0xffF7D6E0),
    Color(0xffE7A8C4),
    Color(0xffC58BC0),
    Color(0xff9C7BC4),
    Color(0xff6C5B9E),
  ]),
  terracottaGrove('Terracotta Grove', AppAsset.paletteTerracottaGrove, [
    Color(0xff3E5E3A),
    Color(0xff6E8B5C),
    Color(0xffD9C9A3),
    Color(0xffC97B4A),
    Color(0xffA8492C),
  ]),
  midnightSage('Midnight Sage', AppAsset.paletteMidnightSage, [
    Color(0xff1F2D2B),
    Color(0xff34514A),
    Color(0xff5E7D6F),
    Color(0xff8FA99A),
    Color(0xffC4D2C7),
  ]),
  goldenHour('Golden Hour', AppAsset.paletteGoldenHour, [
    Color(0xffFFF3D6),
    Color(0xffF6D58A),
    Color(0xffE8A94C),
    Color(0xffCF7C3A),
    Color(0xff8C4A2F),
  ]),
  ivoryWhisper('Ivory Whisper', AppAsset.paletteIvoryWhisper, [
    Color(0xffF7F5EE),
    Color(0xffE8E6D9),
    Color(0xffCFD3C2),
    Color(0xffB3BBA6),
    Color(0xff8E9A82),
  ]),
  warmClay('Warm Clay', AppAsset.paletteWarmClay, [
    Color(0xffF3E7DD),
    Color(0xffE4C7B3),
    Color(0xffCBA188),
    Color(0xffB07E63),
    Color(0xff8A5A43),
  ]),
  arcticAlloy('Arctic Alloy', AppAsset.paletteArcticAlloy, [
    Color(0xff1C1F24),
    Color(0xff3A3F47),
    Color(0xff6B7178),
    Color(0xffAFB4BA),
    Color(0xffEDEFF2),
  ]),
  electricPulse('Electric Pulse', AppAsset.paletteElectricPulse, [
    Color(0xffF9D423),
    Color(0xffFF6B6B),
    Color(0xffEE2A7B),
    Color(0xff8A2BE2),
    Color(0xff2E6BE6),
  ]),
  crimsonNoir('Crimson Noir', AppAsset.paletteCrimsonNoir, [
    Color(0xff7A1F2B),
    Color(0xffC0392B),
    Color(0xff2B2B2B),
    Color(0xff3E6E78),
    Color(0xff1B2A3A),
  ]);

  final String label;
  final AppAsset image;
  final List<Color> colors;
  const ColorPalette(this.label, this.image, this.colors);
}
