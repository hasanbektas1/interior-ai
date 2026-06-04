import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class RateUsDialog extends StatelessWidget {
  const RateUsDialog({super.key, required this.onRate});

  final ValueChanged<int> onRate;

  static Future<void> show(BuildContext context, ValueChanged<int> onRate) {
    return showDialog<void>(
      context: context,
      builder: (_) => RateUsDialog(onRate: onRate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(horizontal: context.width40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: context.height20),
          const Text(
            AppStrings.settingsRateUsTitle,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.height8),
          Text(
            AppStrings.settingsRateUsSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.nickel,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ).symmetricPadding(horizontal: context.width24),
          SizedBox(height: context.height16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int star = 1; star <= 5; star++)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onRate(star),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.width4),
                    child: Icon(
                      Icons.star_border_rounded,
                      size: context.width32,
                      color: AppColors.azure,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: context.height16),
          const Divider(height: 1, color: AppColors.platinum),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).maybePop(),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.height16),
                child: const Text(
                  AppStrings.settingsNotNow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.azure,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
