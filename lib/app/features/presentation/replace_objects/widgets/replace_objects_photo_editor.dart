import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/widgets/photo_picker_box.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ReplaceObjectsPhotoEditor extends StatefulWidget {
  const ReplaceObjectsPhotoEditor({
    super.key,
    required this.photoPath,
    required this.onAdd,
    required this.onRemove,
  });

  final String? photoPath;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  State<ReplaceObjectsPhotoEditor> createState() =>
      _ReplaceObjectsPhotoEditorState();
}

class _ReplaceObjectsPhotoEditorState extends State<ReplaceObjectsPhotoEditor> {
  Offset? _dot;

  @override
  void didUpdateWidget(ReplaceObjectsPhotoEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.photoPath == null && _dot != null) {
      _dot = null;
    }
  }

  void _placeDot(Offset local, Size size) {
    setState(() {
      _dot = Offset(
        (local.dx / size.width).clamp(0.0, 1.0),
        (local.dy / size.height).clamp(0.0, 1.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photoPath == null) {
      return PhotoPickerBox(
        photoPath: null,
        onAdd: widget.onAdd,
        onRemove: widget.onRemove,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) => _placeDot(details.localPosition, size),
          onPanUpdate: (details) => _placeDot(details.localPosition, size),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.width16),
                  child: Image.asset(
                    widget.photoPath!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const ColoredBox(color: AppColors.magnolia),
                  ),
                ),
              ),
              if (_dot != null)
                Positioned(
                  left: _dot!.dx * size.width - context.width12,
                  top: _dot!.dy * size.height - context.width12,
                  child: Container(
                    width: context.width24,
                    height: context.width24,
                    decoration: BoxDecoration(
                      color: AppColors.softPurple,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
              Positioned(
                top: context.height12,
                right: context.width12,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onRemove,
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
          ),
        );
      },
    );
  }
}
