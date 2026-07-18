import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/app_photo.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

/// A single page of a feature intro tutorial.
class TutorialStep {
  const TutorialStep({required this.image, required this.description});

  final AppAsset image;
  final String description;
}

/// One-time feature intro shown as a dialog. Swipes through [steps] with a
/// Next button that becomes Done on the last page.
class FeatureTutorialDialog extends StatefulWidget {
  const FeatureTutorialDialog({super.key, required this.steps});

  final List<TutorialStep> steps;

  static Future<void> show(BuildContext context, List<TutorialStep> steps) {
    return showDialog<void>(
      context: context,
      // Tapping outside must not dismiss the intro; it closes only via Done.
      barrierDismissible: false,
      builder: (_) => FeatureTutorialDialog(steps: steps),
    );
  }

  @override
  State<FeatureTutorialDialog> createState() => _FeatureTutorialDialogState();
}

class _FeatureTutorialDialogState extends State<FeatureTutorialDialog> {
  late final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_index >= widget.steps.length - 1) {
      Navigator.of(context).maybePop();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _index == widget.steps.length - 1;
    // Fixed image box sized from the dialog width so portrait and landscape
    // sources render consistently (and don't zoom/shift as the text height
    // changes between steps).
    final double imageWidth =
        context.width - context.width40 * 2 - context.width20 * 2;
    final double imageHeight = imageWidth;
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: context.width40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.width24),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.width20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: imageHeight + context.height96,
              child: PageView(
                controller: _controller,
                onPageChanged: (value) => setState(() => _index = value),
                children: [
                  for (int i = 0; i < widget.steps.length; i++)
                    _TutorialPage(
                      step: widget.steps[i],
                      stepNumber: i + 1,
                      imageHeight: imageHeight,
                    ),
                ],
              ),
            ),
            SizedBox(height: context.height20),
            AppButton.fill(
              text: isLast ? AppStrings.tutorialDone : AppStrings.tutorialNext,
              onPressed: _onNext,
              backgroundColor: AppColors.hanPurple,
              borderRadius: 14,
              height: 54,
            ),
          ],
        ),
      ),
    );
  }
}

class _TutorialPage extends StatelessWidget {
  const _TutorialPage({
    required this.step,
    required this.stepNumber,
    required this.imageHeight,
  });

  final TutorialStep step;
  final int stepNumber;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(context.width16),
          child: SizedBox(
            width: double.infinity,
            height: imageHeight,
            child: AppPhoto(path: step.image.path),
          ),
        ),
        SizedBox(height: context.height16),
        Text(
          '${AppStrings.tutorialStep} $stepNumber',
          style: const TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.height8),
        Text(
          step.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
