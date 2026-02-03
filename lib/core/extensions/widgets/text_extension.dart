import 'package:flutter/material.dart';

extension TextExtension on Text {
  GestureDetector gestureDetector(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(color: Colors.transparent, child: this),
    );
  }
}
