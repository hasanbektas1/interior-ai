import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Assets {
  Assets._();
  final Assets instance = Assets._();

  Image image(
    String assetPath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(assetPath, width: width, height: height, fit: fit);
  }

  /*   Widget svgIcon(String assetPath,
      {double width = 24, double height = 24, Color? color}) {
    return SvgPicture.asset(assetPath,
        width: width,
        height: height,
        colorFilter: ColorFilter.mode(
          color ?? Colors.black,
          BlendMode.dstIn,
        ));
  } */

  Future<Map<String, dynamic>> loadJson(String assetPath) async {
    try {
      String jsonString = await rootBundle.loadString(assetPath);
      return json.decode(jsonString);
    } catch (e) {
      debugPrint('JSON yüklenirken hata oluştu: $e');
      return {};
    }
  }
}
