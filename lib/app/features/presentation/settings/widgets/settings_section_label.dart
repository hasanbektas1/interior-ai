import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';

class SettingsSectionLabel extends StatelessWidget {
  const SettingsSectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.smokyBlack,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
