import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/gradient_button.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class ResultActionDialog extends StatelessWidget {
  const ResultActionDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    this.showCancel = false,
  });

  final String title;
  final String subtitle;
  final String primaryLabel;
  final bool showCancel;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String primaryLabel,
    bool showCancel = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => ResultActionDialog(
        title: title,
        subtitle: subtitle,
        primaryLabel: primaryLabel,
        showCancel: showCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(horizontal: context.width40),
      child: Padding(
        padding: EdgeInsets.all(context.width24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            SizedBox(height: context.height8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.nickel,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
            SizedBox(height: context.height20),
            GradientButton(
              text: primaryLabel,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            if (showCancel) ...[
              SizedBox(height: context.height8),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(false),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height12),
                  child: const Text(
                    AppStrings.interiorCancel,
                    style: TextStyle(
                      color: AppColors.azure,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
