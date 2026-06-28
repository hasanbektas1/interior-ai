import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';

/// Renders a photo from either a bundled asset path (`assets/...`) or a device
/// file path returned by the image picker, choosing the correct image source.
class AppPhoto extends StatelessWidget {
  const AppPhoto({super.key, required this.path, this.fit = BoxFit.cover});

  final String path;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: fit,
        errorBuilder: (_, __, ___) =>
            const ColoredBox(color: AppColors.magnolia),
      );
    }
    return Image.file(
      File(path),
      fit: fit,
      errorBuilder: (_, __, ___) => const ColoredBox(color: AppColors.magnolia),
    );
  }
}
