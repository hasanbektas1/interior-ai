import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class PaywallBackground extends StatelessWidget {
  const PaywallBackground({super.key, this.heightFactor = 0.6});

  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: context.height * heightFactor,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white, Colors.transparent],
            stops: [0.0, 0.55, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          AppAsset.paywallBackground.path,
          fit: BoxFit.cover,
          errorBuilder: (context, _, __) =>
              Container(color: AppColors.magnolia),
        ),
      ),
    );
  }
}
