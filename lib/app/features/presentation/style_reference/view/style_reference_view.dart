import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/feature_tutorial.dart';
import 'package:interior_ai/app/common/widgets/generated_error_view.dart';
import 'package:interior_ai/app/common/widgets/step_flow_header.dart';
import 'package:interior_ai/app/common/widgets/step_page_view.dart';
import 'package:interior_ai/app/common/widgets/generated_processing_view.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_cubit.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_state.dart';
import 'package:interior_ai/app/features/presentation/style_reference/enums/style_reference_step.dart';
import 'package:interior_ai/app/features/presentation/style_reference/view/steps/style_reference_photo_step.dart';
import 'package:interior_ai/app/features/presentation/style_reference/view/style_reference_result_view.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class StyleReferenceView extends StatelessWidget {
  const StyleReferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StyleReferenceBody();
  }
}

class _StyleReferenceBody extends StatelessWidget {
  const _StyleReferenceBody();

  // Leave the flow, then clear its state so re-entering always starts fresh
  // (never re-shows the previous result). Reset runs after the pop completes.
  Future<void> _exit(BuildContext context) async {
    final nav = Navigator.of(context);
    final cubit = context.read<StyleReferenceCubit>();
    await nav.maybePop();
    cubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) FeatureTutorial.styleReference(context);
    });
    return BlocBuilder<StyleReferenceCubit, StyleReferenceState>(
      builder: (context, state) {
        final cubit = context.read<StyleReferenceCubit>();

        if (state.step == StyleReferenceStep.processing) {
          return GeneratedProcessingView(
            onBackToHome: () => _exit(context),
            onBack: () => _exit(context),
          );
        }
        if (state.step == StyleReferenceStep.result) {
          return StyleReferenceResultView(
            imagePath: state.resultImagePath ?? '',
            onClose: () => _exit(context),
            onRegenerate: cubit.retry,
          );
        }
        if (state.step == StyleReferenceStep.error) {
          return GeneratedErrorView(
            onTryAgain: cubit.retry,
            onBackToHome: () => _exit(context),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.ghostWhite,
          body: SafeArea(
            child: Column(
              children: [
                StepFlowHeader(
                  title: AppStrings.styleReference,
                  filledCount: state.step.progressIndex + 1,
                  count: 2,
                  onClose: () => _exit(context),
                ),
                Expanded(
                  child: StepPageView(
                    index: state.step.progressIndex,
                    children: [
                      StyleReferencePhotoStep(
                        label: AppStrings.interiorAddYourPhoto,
                        photoPath: state.photoSelectedPath,
                        exampleIndex: state.photoIndex,
                        photos: kStylePhotos,
                      ),
                      StyleReferencePhotoStep(
                        label: AppStrings.styleAddReferencePhoto,
                        photoPath: state.refSelectedPath,
                        exampleIndex: state.refIndex,
                        photos: kReferencePhotos,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height4),
                AppButton.fill(
                  text: AppStrings.interiorContinue,
                  onPressed: state.canContinue ? cubit.next : null,
                  backgroundColor: AppColors.hanPurple,
                  disabledBackgroundColor: AppColors.disabledGray,
                  disabledTextColor: AppColors.disabledText,
                  borderRadius: 14,
                  height: 54,
                ),
                SizedBox(height: context.height16),
              ],
            ).symmetricPadding(horizontal: context.width24),
          ),
        );
      },
    );
  }
}
