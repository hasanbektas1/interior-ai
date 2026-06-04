import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/interior_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/add_photo_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/color_palette_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/interior_error_view.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/interior_processing_view.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/interior_result_view.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/room_type_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/style_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/interior_header.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class InteriorDesignView extends StatelessWidget {
  const InteriorDesignView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _InteriorDesignBody();
  }
}

class _InteriorDesignBody extends StatelessWidget {
  const _InteriorDesignBody();

  void _exit(BuildContext context) => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteriorDesignCubit, InteriorDesignState>(
      builder: (context, state) {
        final cubit = context.read<InteriorDesignCubit>();

        if (state.step == InteriorStep.processing) {
          return InteriorProcessingView(onBackToHome: () => _exit(context));
        }
        if (state.step == InteriorStep.result) {
          return InteriorResultView(
            state: state,
            onClose: () => _exit(context),
            onRegenerate: cubit.retry,
          );
        }
        if (state.step == InteriorStep.error) {
          return InteriorErrorView(
            onTryAgain: cubit.retry,
            onBackToHome: () => _exit(context),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.ghostWhite,
          body: SafeArea(
            child: Column(
              children: [
                InteriorHeader(
                  filledCount: state.step.progressIndex + 1,
                  onClose: () => _exit(context),
                  onBack: state.step == InteriorStep.addPhoto ? null : cubit.back,
                ),
                Expanded(
                  child: ClipRect(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: KeyedSubtree(
                        key: ValueKey(state.step),
                        child: _StepContent(state: state),
                      ),
                    ),
                  ),
                ),
                AppButton.fill(
                  text: AppStrings.interiorContinue,
                  onPressed: state.canContinue ? cubit.next : null,
                  backgroundColor: AppColors.softPurple,
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

  final InteriorDesignState state;

  @override
  Widget build(BuildContext context) {
    return switch (state.step) {
      InteriorStep.addPhoto => AddPhotoStep(state: state),
      InteriorStep.roomType => RoomTypeStep(state: state),
      InteriorStep.style => StyleStep(state: state),
      InteriorStep.colorPalette => ColorPaletteStep(state: state),
      InteriorStep.processing => const SizedBox.shrink(),
      InteriorStep.result => const SizedBox.shrink(),
      InteriorStep.error => const SizedBox.shrink(),
    };
  }
}
