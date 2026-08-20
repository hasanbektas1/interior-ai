import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/step_flow_header.dart';
import 'package:interior_ai/app/common/widgets/step_page_view.dart';
import 'package:interior_ai/app/common/widgets/generated_error_view.dart';
import 'package:interior_ai/app/common/widgets/generated_processing_view.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_state.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/enums/exterior_step.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/view/exterior_result_view.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/view/steps/building_type_step.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/view/steps/exterior_add_photo_step.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/view/steps/exterior_palette_step.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/view/steps/exterior_style_step.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class ExteriorDesignView extends StatelessWidget {
  const ExteriorDesignView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ExteriorDesignBody();
  }
}

class _ExteriorDesignBody extends StatelessWidget {
  const _ExteriorDesignBody();

  void _exit(BuildContext context) => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExteriorDesignCubit, ExteriorDesignState>(
      builder: (context, state) {
        final cubit = context.read<ExteriorDesignCubit>();

        if (state.step == ExteriorStep.processing) {
          return GeneratedProcessingView(
            onBackToHome: () => _exit(context),
            onBack: () => _exit(context),
          );
        }
        if (state.step == ExteriorStep.result) {
          return ExteriorResultView(
            imagePath: state.resultImagePath ?? '',
            buildingTypeLabel: state.buildingType?.label ?? '',
            styleLabel: state.style?.label ?? '',
            customPrompt: state.customPrompt,
            onClose: () => _exit(context),
            onRegenerate: cubit.retry,
          );
        }
        if (state.step == ExteriorStep.error) {
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
                  title: AppStrings.exteriorDesign,
                  filledCount: state.step.progressIndex + 1,
                  count: 4,
                  onClose: () => _exit(context),
                  onBack:
                      state.step == ExteriorStep.addPhoto ? null : cubit.back,
                ),
                Expanded(
                  child: StepPageView(
                    index: state.step.progressIndex,
                    children: [
                      ExteriorAddPhotoStep(state: state),
                      BuildingTypeStep(state: state),
                      ExteriorStyleStep(state: state),
                      ExteriorPaletteStep(state: state),
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
