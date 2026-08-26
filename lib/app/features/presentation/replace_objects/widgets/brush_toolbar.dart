import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class BrushToolbar extends StatelessWidget {
  const BrushToolbar({
    super.key,
    required this.brushSize,
    required this.onBrushSizeChanged,
    required this.onUndo,
    required this.onRedo,
    this.enabled = true,
  });

  final double brushSize;
  final ValueChanged<double> onBrushSizeChanged;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = enabled
        ? AppColors.smokyBlack
        : AppColors.spanishGray;
    return Row(
      children: [
        Icon(Icons.brush_rounded, size: context.width20, color: iconColor),
        SizedBox(width: context.width12),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              activeTrackColor: AppColors.softPurple,
              inactiveTrackColor: AppColors.platinum,
              thumbColor: AppColors.softPurple,
              overlayShape: SliderComponentShape.noOverlay,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider(
              value: brushSize,
              onChanged: enabled ? onBrushSizeChanged : null,
            ),
          ),
        ),
        SizedBox(width: context.width12),
        Icon(Icons.brush_rounded, size: context.width32, color: iconColor),
        SizedBox(width: context.width20),
        _SvgIconButton(
          asset: AppAsset.replaceObjectsUndo,
          color: iconColor,
          onTap: enabled ? onUndo : null,
        ),
        SizedBox(width: context.width16),
        _SvgIconButton(
          asset: AppAsset.replaceObjectsRedo,
          color: iconColor,
          onTap: enabled ? onRedo : null,
        ),
      ],
    );
  }
}

class _SvgIconButton extends StatelessWidget {
  const _SvgIconButton({
    required this.asset,
    required this.color,
    required this.onTap,
  });

  final AppAsset asset;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SvgPicture.asset(
        asset.path,
        width: context.width24,
        height: context.width24,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
