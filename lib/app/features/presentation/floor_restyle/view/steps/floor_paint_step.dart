import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_cubit.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_state.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/widgets/paint_mask_canvas.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class FloorPaintStep extends StatefulWidget {
  const FloorPaintStep({super.key, required this.state});

  final FloorRestyleState state;

  @override
  State<FloorPaintStep> createState() => _FloorPaintStepState();
}

class _FloorPaintStepState extends State<FloorPaintStep> {
  final GlobalKey<PaintMaskCanvasState> _canvasKey = GlobalKey();
  double _brushSize = 0.3;
  bool _isEraser = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FloorRestyleCubit>();
    return Column(
      children: [
        SizedBox(height: context.height16),
        Expanded(
          child: PaintMaskCanvas(
            key: _canvasKey,
            photoPath: widget.state.selectedPhotoPath ?? '',
            brushSize: _brushSize,
            isEraser: _isEraser,
            onChanged: cubit.setPainted,
          ),
        ),
        SizedBox(height: context.height16),
        Row(
          children: [
            _ToolButton(
              icon: Icons.brush_rounded,
              isSelected: !_isEraser,
              onTap: () => setState(() => _isEraser = false),
            ),
            SizedBox(width: context.width12),
            _ToolButton(
              icon: Icons.auto_fix_normal_rounded,
              isSelected: _isEraser,
              onTap: () => setState(() => _isEraser = true),
            ),
            const Spacer(),
            _IconButton(
              icon: Icons.undo_rounded,
              onTap: () => _canvasKey.currentState?.undo(),
            ),
            SizedBox(width: context.width12),
            _IconButton(
              icon: Icons.redo_rounded,
              onTap: () => _canvasKey.currentState?.redo(),
            ),
          ],
        ),
        SizedBox(height: context.height16),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.floorBrushSize,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 3,
            activeTrackColor: AppColors.softPurple,
            inactiveTrackColor: AppColors.platinum,
            thumbColor: AppColors.softPurple,
            overlayShape: SliderComponentShape.noOverlay,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
          ),
          child: Slider(
            value: _brushSize,
            onChanged: (v) => setState(() => _brushSize = v),
          ),
        ),
      ],
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: context.width44,
        height: context.width44,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.softPurpleFaint : AppColors.cloudGray,
          borderRadius: BorderRadius.circular(context.width12),
          border: Border.all(
            color: isSelected ? AppColors.softPurple : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: context.width24,
          color: isSelected ? AppColors.softPurple : AppColors.smokyBlack,
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: context.width44,
        height: context.width44,
        decoration: const BoxDecoration(
          color: AppColors.cloudGray,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: context.width24, color: AppColors.smokyBlack),
      ),
    );
  }
}
