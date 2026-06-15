import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/gem_header.dart';
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
    return const _FloorRestyleBody();
  }
}

class _FloorRestyleBody extends StatelessWidget {
  const _FloorRestyleBody();

  void _exit(BuildContext context) => Navigator.of(context).maybePop();

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
            materialLabel: state.material?.label ?? '',
            customPrompt: state.customPrompt,
            onClose: () => _exit(context),
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
                GemHeader(
                  title: AppStrings.floorRestyle,
                  progressFilledCount: state.step.progressIndex + 1,
                  progressCount: 3,
                  onClose: () => _exit(context),
                  onBack: state.step == FloorStep.addPhoto ? null : cubit.back,
                ),
                Expanded(
                  child: ClipRect(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: SizedBox.expand(
                        key: ValueKey(state.step),
                        child: _StepContent(state: state),
                      ),
                    ),
                  ),
                ),
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

class _StepContent extends StatelessWidget {
  const _StepContent({required this.state});

  final FloorRestyleState state;

  @override
  Widget build(BuildContext context) {
    return switch (state.step) {
      FloorStep.addPhoto => FloorAddPhotoStep(state: state),
      FloorStep.paint => FloorPaintStep(state: state),
      FloorStep.material => FloorMaterialStep(state: state),
      FloorStep.processing => const SizedBox.shrink(),
      FloorStep.result => const SizedBox.shrink(),
      FloorStep.error => const SizedBox.shrink(),
    };
  }
}
