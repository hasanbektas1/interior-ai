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
import 'package:interior_ai/app/common/widgets/generated_error_view.dart';
import 'package:interior_ai/app/common/widgets/generated_processing_view.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/interior_result_view.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/room_type_step.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/steps/style_step.dart';
import 'package:interior_ai/app/common/widgets/dialogs/feature_tutorial.dart';
import 'package:interior_ai/app/common/widgets/step_flow_header.dart';
import 'package:interior_ai/app/common/widgets/step_page_view.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class InteriorDesignView extends StatelessWidget {
  const InteriorDesignView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) FeatureTutorial.interior(context);
    });
    // The flow can only be left through its own close/back buttons — system
    // back and the iOS edge-swipe are disabled (canPop: false) — so `close()`
    // is the single exit and always clears the state, letting re-entry start
    // fresh (never re-showing the previous result).
    return PopScope(
      canPop: false,
      child: BlocBuilder<InteriorDesignCubit, InteriorDesignState>(
        builder: (context, state) {
          final cubit = context.read<InteriorDesignCubit>();

          Future<void> close() async {
            Navigator.of(context).pop();
            cubit.reset();
          }

          if (state.step == InteriorStep.processing) {
            return GeneratedProcessingView(onBackToHome: close, onBack: close);
          }
          if (state.step == InteriorStep.result) {
            return InteriorResultView(
              state: state,
              onClose: close,
              onDelete: () async {
                await cubit.deleteCurrentResult();
                await close();
              },
              onRegenerate: cubit.retry,
            );
          }
          if (state.step == InteriorStep.error) {
            return GeneratedErrorView(
              onTryAgain: cubit.retry,
              onBackToHome: close,
            );
          }

          return Scaffold(
            backgroundColor: AppColors.ghostWhite,
            body: SafeArea(
              child: Column(
                children: [
                  StepFlowHeader(
                    title: AppStrings.interiorDesign,
                    filledCount: state.step.progressIndex + 1,
                    onClose: close,
                    onBack: state.step == InteriorStep.addPhoto
                        ? null
                        : cubit.back,
                  ),
                  Expanded(
                    child: StepPageView(
                      index: state.step.progressIndex,
                      children: [
                        AddPhotoStep(state: state),
                        RoomTypeStep(state: state),
                        StyleStep(state: state),
                        ColorPaletteStep(state: state),
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
      ),
    );
  }
}
