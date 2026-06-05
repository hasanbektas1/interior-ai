import 'package:flutter/material.dart';

enum ExteriorColorPalette {
  random('Random', [
    Color(0xff2E6BE6),
    Color(0xff8A2BE2),
    Color(0xff6CC551),
    Color(0xffF2C14E),
    Color(0xffE8743B),
  ]),
  skyfire('Skyfire', [
    Color(0xffB8DCEF),
    Color(0xff2E8FB0),
    Color(0xff14324F),
    Color(0xffF2A93B),
    Color(0xffE8761F),
  ]),
  cottonCandyDusk('Cotton Candy Dusk', [
    Color(0xffBFE0F2),
    Color(0xffF5C6D9),
    Color(0xffEBA8C4),
    Color(0xffBFD9F0),
    Color(0xffA9CBEF),
  ]),
  rusticEarth('Rustic Earth', [
    Color(0xff3E5E3A),
    Color(0xff6E8B5C),
    Color(0xffF5EFD9),
    Color(0xffC97B4A),
    Color(0xffA8612C),
  ]),
  sageMidnight('Sage & Midnight', [
    Color(0xff9DB3A4),
    Color(0xff5E7D6F),
    Color(0xff34514A),
    Color(0xff223A36),
    Color(0xff1F2D2B),
  ]),
  sunsetHarvest('Sunset Harvest', [
    Color(0xff8FA99A),
    Color(0xff3E8E8E),
    Color(0xffF5EFD9),
    Color(0xffE8A94C),
    Color(0xffE8743B),
  ]);

  final String label;
  final List<Color> colors;
  const ExteriorColorPalette(this.label, this.colors);
}
