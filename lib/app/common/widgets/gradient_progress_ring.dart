import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';

class GradientProgressRing extends StatefulWidget {
  const GradientProgressRing({
    super.key,
    required this.size,
    this.strokeWidth = 9,
    this.trackColor = AppColors.platinum,
  });

  final double size;
  final double strokeWidth;
  final Color trackColor;

  @override
  State<GradientProgressRing> createState() => _GradientProgressRingState();
}

class _GradientProgressRingState extends State<GradientProgressRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: RotationTransition(
        turns: _controller,
        child: CustomPaint(
          painter: _RingPainter(
            strokeWidth: widget.strokeWidth,
            trackColor: widget.trackColor,
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.strokeWidth, required this.trackColor});

  final double strokeWidth;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(center, radius, trackPaint);

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          AppColors.progressArcStart,
          AppColors.progressArcEnd,
          AppColors.progressArcStart,
        ],
        stops: [0.0, 0.7, 1.0],
      ).createShader(rect);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 1.5, false, arcPaint);
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.trackColor != trackColor;
}
