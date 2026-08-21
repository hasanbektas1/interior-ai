import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';

/// Renders a photo from either a bundled asset path (`assets/...`) or a device
/// file path returned by the image picker, choosing the correct image source.
///
/// The image is decoded at its on-screen size (`cacheWidth` = laid-out width ×
/// device pixel ratio) so large source images don't sit in memory at full
/// resolution — important for grids and scrolling lists.
class AppPhoto extends StatelessWidget {
  const AppPhoto({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.gaplessPlayback = false,
  });

  final String path;
  final BoxFit fit;
  final bool gaplessPlayback;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    final isAsset = path.startsWith('assets/');
    return LayoutBuilder(
      builder: (context, constraints) {
        final int? cacheWidth = constraints.maxWidth.isFinite
            ? (constraints.maxWidth * dpr).round().clamp(1, 4096).toInt()
            : null;
        if (isAsset) {
          return Image.asset(
            path,
            fit: fit,
            cacheWidth: cacheWidth,
            gaplessPlayback: gaplessPlayback,
            errorBuilder: (_, __, ___) =>
                const ColoredBox(color: AppColors.magnolia),
          );
        }
        return Image.file(
          File(path),
          fit: fit,
          cacheWidth: cacheWidth,
          gaplessPlayback: gaplessPlayback,
          errorBuilder: (_, __, ___) =>
              const ColoredBox(color: AppColors.magnolia),
        );
      },
    );
  }
}
