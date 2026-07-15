import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/step_flow_header.dart';
import 'package:interior_ai/app/common/widgets/step_page_view.dart';
import 'package:interior_ai/app/common/widgets/generated_error_view.dart';
import 'package:interior_ai/app/common/widgets/generated_processing_view.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_state.dart';
import 'package:interior_ai/app/features/presentation/garden_design/enums/garden_step.dart';
import 'package:interior_ai/app/features/presentation/garden_design/view/garden_result_view.dart';
import 'package:interior_ai/app/features/presentation/garden_design/view/steps/garden_add_photo_step.dart';
import 'package:interior_ai/app/features/presentation/garden_design/view/steps/garden_style_step.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class GardenDesignView extends StatelessWidget {
  const GardenDesignView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _GardenDesignBody();
  }
}

class _GardenDesignBody extends StatelessWidget {
  const _GardenDesignBody();

  void _exit(BuildContext context) => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GardenDesignCubit, GardenDesignState>(
      builder: (context, state) {
        final cubit = context.read<GardenDesignCubit>();

        if (state.step == GardenStep.processing) {
          return GeneratedProcessingView(
            onBackToHome: () => _exit(context),
            onBack: () => _exit(context),
          );
        }
        if (state.step == GardenStep.result) {
          return GardenResultView(
            styleLabel: state.style?.label ?? '',
            customPrompt: state.customPrompt,
            onClose: () => _exit(context),
            onRegenerate: cubit.retry,
          );
        }
        if (state.step == GardenStep.error) {
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
                  title: AppStrings.gardenDesign,
                  filledCount: state.step.progressIndex + 1,
                  count: 2,
                  onClose: () => _exit(context),
                  onBack: state.step == GardenStep.style ? cubit.back : null,
                ),
                Expanded(
                  child: StepPageView(
                    index: state.step.progressIndex,
                    children: [
                      GardenAddPhotoStep(state: state),
                      GardenStyleStep(state: state),
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
