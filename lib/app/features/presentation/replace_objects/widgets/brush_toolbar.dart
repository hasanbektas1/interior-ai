import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class BrushToolbar extends StatefulWidget {
  const BrushToolbar({super.key, this.enabled = true});

  final bool enabled;

  @override
  State<BrushToolbar> createState() => _BrushToolbarState();
}

class _BrushToolbarState extends State<BrushToolbar> {
  double _value = 0.2;

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        widget.enabled ? AppColors.smokyBlack : AppColors.spanishGray;
    return Row(
      children: [
        Icon(Icons.brush_rounded, size: context.width20, color: iconColor),
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
              value: _value,
              onChanged: widget.enabled
                  ? (v) => setState(() => _value = v)
                  : null,
            ),
          ),
        ),
        Icon(Icons.undo_rounded, size: context.width24, color: iconColor),
        SizedBox(width: context.width16),
        Icon(Icons.redo_rounded, size: context.width24, color: iconColor),
      ],
    );
  }
}
