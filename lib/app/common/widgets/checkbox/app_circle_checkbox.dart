import 'package:flutter/material.dart';

final class AppCircleCheckbox extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const AppCircleCheckbox({
    super.key,
    required this.isSelected,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isSelected);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
              color: isSelected ? Colors.red : Colors.grey, width: 2),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
