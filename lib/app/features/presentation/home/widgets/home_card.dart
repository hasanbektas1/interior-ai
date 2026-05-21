import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_home_assets.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.image,
    required this.onTap,
  });

  final AppHomeImage image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          image.path,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          errorBuilder: (_, __, ___) => const ColoredBox(
            color: AppColors.magnolia,
          ),
        ),
      ),
    );
  }
}
