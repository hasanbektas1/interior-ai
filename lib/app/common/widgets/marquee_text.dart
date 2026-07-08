import 'package:flutter/material.dart';

/// Single-line text that scrolls horizontally in a seamless loop when it does
/// not fit its available width, and renders as a plain static line when it
/// does. Used for card subtitles that would otherwise wrap.
class MarqueeText extends StatefulWidget {
  const MarqueeText({
    super.key,
    required this.text,
    required this.style,
    this.gap = 40,
    this.velocity = 30,
  });

  final String text;
  final TextStyle style;

  /// Empty space between the end of the text and the start of its repeat.
  final double gap;

  /// Scroll speed in logical pixels per second.
  final double velocity;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final line = Text(
      widget.text,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.clip,
      style: widget.style,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: 1,
          textDirection: Directionality.of(context),
        )..layout();

        if (painter.width <= maxWidth) {
          _controller.stop();
          return line;
        }

        final scrollExtent = painter.width + widget.gap;
        if (!_controller.isAnimating) {
          _controller
            ..duration = Duration(
              milliseconds: (scrollExtent / widget.velocity * 1000).round(),
            )
            ..repeat();
        }

        return SizedBox(
          width: maxWidth,
          height: painter.height,
          child: ClipRect(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.translate(
                offset: Offset(-scrollExtent * _controller.value, 0),
                child: child,
              ),
              child: OverflowBox(
                maxWidth: double.infinity,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    line,
                    SizedBox(width: widget.gap),
                    line,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
