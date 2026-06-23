import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/paint_mask_canvas.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_cubit.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_state.dart';
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
              asset: AppAsset.floorBrushIcon,
              isSelected: !_isEraser,
              onTap: () => setState(() => _isEraser = false),
            ),
            SizedBox(width: context.width12),
            _ToolButton(
              asset: AppAsset.floorEraserIcon,
              isSelected: _isEraser,
              onTap: () => setState(() => _isEraser = true),
            ),
            const Spacer(),
            _IconButton(
              asset: AppAsset.replaceObjectsUndo,
              onTap: () => _canvasKey.currentState?.undo(),
            ),
            SizedBox(width: context.width12),
            _IconButton(
              asset: AppAsset.replaceObjectsRedo,
              onTap: () => _canvasKey.currentState?.redo(),
            ),
          ],
        ),
        SizedBox(height: context.height16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _isEraser ? AppStrings.floorEraserSize : AppStrings.floorBrushSize,
            style: const TextStyle(
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
            trackShape: const _EdgeToEdgeTrackShape(),
          ),
          child: Slider(
            value: _brushSize,
            onChanged: (v) => setState(() => _brushSize = v),
          ),
        ),
        SizedBox(height: context.height16),
      ],
    );
  }
}

class _EdgeToEdgeTrackShape extends RoundedRectSliderTrackShape {
  const _EdgeToEdgeTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 3;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(
      offset.dx,
      trackTop,
      parentBox.size.width,
      trackHeight,
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.asset,
    required this.isSelected,
    required this.onTap,
  });

  final AppAsset asset;
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
        child: Center(
          child: SvgPicture.asset(
            asset.path,
            width: context.width24,
            height: context.width24,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.softPurple : AppColors.smokyBlack,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.asset, required this.onTap});

  final AppAsset asset;
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
        child: Center(
          child: SvgPicture.asset(
            asset.path,
            width: context.width24,
            height: context.width24,
            colorFilter: const ColorFilter.mode(
              AppColors.smokyBlack,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
