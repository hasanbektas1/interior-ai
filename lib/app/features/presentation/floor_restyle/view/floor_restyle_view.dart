import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/step_flow_header.dart';
import 'package:interior_ai/app/common/widgets/step_page_view.dart';
import 'package:interior_ai/app/common/widgets/generated_error_view.dart';
import 'package:interior_ai/app/common/widgets/generated_processing_view.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_cubit.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_state.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/enums/floor_step.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/view/floor_result_view.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/view/steps/floor_add_photo_step.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/view/steps/floor_material_step.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/view/steps/floor_paint_step.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class FloorRestyleView extends StatelessWidget {
  const FloorRestyleView({super.key});

  @override
  Widget build(BuildContext context) {
    // The flow can only be left through its own close/back buttons — system
    // back and the iOS edge-swipe are disabled (canPop: false) — so `_exit`
    // is the single exit and always clears the state, letting re-entry start
    // fresh (never re-showing the previous result).
    return PopScope(canPop: false, child: const _FloorRestyleBody());
  }
}

class _FloorRestyleBody extends StatelessWidget {
  const _FloorRestyleBody();

  Future<void> _exit(BuildContext context) async {
    final cubit = context.read<FloorRestyleCubit>();
    Navigator.of(context).pop();
    cubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloorRestyleCubit, FloorRestyleState>(
      builder: (context, state) {
        final cubit = context.read<FloorRestyleCubit>();

        if (state.step == FloorStep.processing) {
          return GeneratedProcessingView(
            onBackToHome: () => _exit(context),
            onBack: () => _exit(context),
          );
        }
        if (state.step == FloorStep.result) {
          return FloorResultView(
            imagePath: state.resultImagePath ?? '',
            materialLabel: state.material?.label ?? '',
            customPrompt: state.customPrompt,
            onClose: () => _exit(context),
            onDelete: () async {
              final nav = Navigator.of(context);
              await cubit.deleteCurrentResult();
              nav.pop();
              cubit.reset();
            },
            onRegenerate: cubit.retry,
          );
        }
        if (state.step == FloorStep.error) {
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
                  title: AppStrings.floorRestyle,
                  filledCount: state.step.progressIndex + 1,
                  count: 3,
                  onClose: () => _exit(context),
                  onBack: state.step == FloorStep.addPhoto ? null : cubit.back,
                ),
                Expanded(
                  child: StepPageView(
                    index: state.step.progressIndex,
                    children: [
                      FloorAddPhotoStep(state: state),
                      FloorPaintStep(state: state),
                      FloorMaterialStep(state: state),
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
