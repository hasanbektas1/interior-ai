import 'package:flutter/material.dart';

/// Shows one of [children] at a time, picked by [index], and animates
/// between them with a plain horizontal page slide (right-to-left moving
/// forward, left-to-right moving back) - the same transition a normal
/// [PageView] uses, without exposing swipe gestures to the user.
class StepPageView extends StatefulWidget {
  const StepPageView({super.key, required this.index, required this.children});

  final int index;
  final List<Widget> children;

  @override
  State<StepPageView> createState() => _StepPageViewState();
}

class _StepPageViewState extends State<StepPageView> {
  late final PageController _controller = PageController(
    initialPage: widget.index,
  );

  @override
  void didUpdateWidget(covariant StepPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _controller.animateToPage(
        widget.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.children,
    );
  }
}
