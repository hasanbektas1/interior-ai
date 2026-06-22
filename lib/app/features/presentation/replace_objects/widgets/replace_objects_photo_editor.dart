import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/widgets/paint_mask_canvas.dart';
import 'package:interior_ai/app/common/widgets/photo_picker_box.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ReplaceObjectsPhotoEditor extends StatelessWidget {
  const ReplaceObjectsPhotoEditor({
    super.key,
    required this.photoPath,
    required this.brushSize,
    required this.canvasKey,
    required this.onAdd,
    required this.onRemove,
    required this.onPaintedChanged,
  });

  final String? photoPath;
  final double brushSize;
  final GlobalKey<PaintMaskCanvasState> canvasKey;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final ValueChanged<bool> onPaintedChanged;

  @override
  Widget build(BuildContext context) {
    if (photoPath == null) {
      return PhotoPickerBox(photoPath: null, onAdd: onAdd, onRemove: onRemove);
    }

    return Stack(
      children: [
        Positioned.fill(
          child: PaintMaskCanvas(
            key: canvasKey,
            photoPath: photoPath!,
            brushSize: brushSize,
            isEraser: false,
            onChanged: onPaintedChanged,
          ),
        ),
        Positioned(
          top: context.height12,
          right: context.width12,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onRemove,
            child: Container(
              width: context.width28,
              height: context.width28,
              decoration: BoxDecoration(
                color: AppColors.smokyBlack.withValues(alpha: 0.45),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: context.width20,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
