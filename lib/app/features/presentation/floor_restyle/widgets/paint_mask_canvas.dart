import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class _Stroke {
  _Stroke({required this.width, required this.erase});
  final List<Offset> points = [];
  final double width;
  final bool erase;
}

class PaintMaskCanvas extends StatefulWidget {
  const PaintMaskCanvas({
    super.key,
    required this.photoPath,
    required this.brushSize,
    required this.isEraser,
    required this.onChanged,
  });

  final String photoPath;
  final double brushSize;
  final bool isEraser;
  final ValueChanged<bool> onChanged;

  @override
  State<PaintMaskCanvas> createState() => PaintMaskCanvasState();
}

class PaintMaskCanvasState extends State<PaintMaskCanvas> {
  final List<_Stroke> _strokes = [];
  final List<_Stroke> _redo = [];

  double get _width => 10 + widget.brushSize * 44;

  bool get canUndo => _strokes.isNotEmpty;
  bool get canRedo => _redo.isNotEmpty;

  void undo() {
    if (_strokes.isEmpty) return;
    setState(() => _redo.add(_strokes.removeLast()));
    widget.onChanged(_strokes.isNotEmpty);
  }

  void redo() {
    if (_redo.isEmpty) return;
    setState(() => _strokes.add(_redo.removeLast()));
    widget.onChanged(true);
  }

  void _start(Offset point) {
    final stroke = _Stroke(width: _width, erase: widget.isEraser)
      ..points.add(point);
    setState(() {
      _strokes.add(stroke);
      _redo.clear();
    });
    widget.onChanged(true);
  }

  void _extend(Offset point) {
    if (_strokes.isEmpty) return;
    setState(() => _strokes.last.points.add(point));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.width16),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (d) => _start(d.localPosition),
        onPanUpdate: (d) => _extend(d.localPosition),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.photoPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const ColoredBox(color: AppColors.magnolia),
            ),
            CustomPaint(painter: _MaskPainter(_strokes), size: Size.infinite),
          ],
        ),
      ),
    );
  }
}

class _MaskPainter extends CustomPainter {
  _MaskPainter(this.strokes);

  final List<_Stroke> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (final stroke in strokes) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke.width
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      if (stroke.erase) {
        paint.blendMode = BlendMode.clear;
      } else {
        paint.color = AppColors.softPurple.withValues(alpha: 0.45);
      }
      if (stroke.points.length == 1) {
        final dot = Paint()
          ..color = paint.color
          ..blendMode = paint.blendMode
          ..style = PaintingStyle.fill;
        canvas.drawCircle(stroke.points.first, stroke.width / 2, dot);
      } else {
        final path = Path()..moveTo(stroke.points.first.dx, stroke.points.first.dy);
        for (final point in stroke.points.skip(1)) {
          path.lineTo(point.dx, point.dy);
        }
        canvas.drawPath(path, paint);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_MaskPainter oldDelegate) => true;
}
