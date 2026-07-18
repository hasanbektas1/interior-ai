import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/features/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:interior_ai/app/features/presentation/onboarding/cubit/onboarding_state.dart';
import 'package:interior_ai/app/features/presentation/onboarding/view/dream_space_view.dart';
import 'package:interior_ai/app/features/presentation/onboarding/view/find_style_view.dart';
import 'package:interior_ai/app/features/presentation/onboarding/view/help_us_grow_view.dart';
import 'package:interior_ai/app/features/presentation/onboarding/view/pick_space_view.dart';
import 'package:interior_ai/app/features/presentation/onboarding/view/processing_view.dart';
import 'package:interior_ai/app/features/presentation/onboarding/view/welcome_view.dart';
import 'package:interior_ai/app/features/presentation/onboarding/widgets/onboarding_page_indicator.dart';
import 'package:interior_ai/app/features/presentation/main/view/main_view.dart';
import 'package:interior_ai/core/helpers/app_rate.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return Scaffold(
          backgroundColor: AppColors.ghostWhite,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: ClipRect(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          transitionBuilder: (child, animation) {
                            final isIncoming =
                                child.key == ValueKey(state.pageIndex);
                            final offsetTween = Tween<Offset>(
                              begin: isIncoming
                                  ? const Offset(1.0, 0.0)
                                  : const Offset(-1.0, 0.0),
                              end: Offset.zero,
                            );
                            return SlideTransition(
                              position: offsetTween.animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                              ),
                              child: child,
                            );
                          },
                          child: KeyedSubtree(
                            key: ValueKey(state.pageIndex),
                            child: switch (state.pageIndex) {
                              1 => PickSpaceView(
                                selectedSpace: state.selectedSpace,
                                onSelect: cubit.selectSpace,
                              ),
                              2 => FindStyleView(
                                selectedStyle: state.selectedStyle,
                                onSelect: cubit.selectStyle,
                              ),
                              3 => const ProcessingView(),
                              4 => DreamSpaceView(
                                mainImage: state.dreamMainImage,
                                miniImage: state.dreamMiniImage,
                              ),
                              5 => const HelpUsGrowView(),
                              _ => const WelcomeView(),
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OnboardingPageIndicator(
                            currentIndex: state.pageIndex,
                            count: 6,
                          ),
                          const SizedBox(height: 16),
                          AppButton.fill(
                            text: state.buttonText,
                            onPressed: state.isButtonEnabled
                                ? () async {
                                    if (state.step ==
                                        OnboardingStep.helpUsGrow) {
                                      await AppRate.request();
                                      if (!context.mounted) return;
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (_) => const MainView(),
                                        ),
                                        (_) => false,
                                      );
                                      return;
                                    }
                                    cubit.onButtonPressed();
                                  }
                                : null,
                            borderRadius: 14,
                            height: 54,
                            disabledBackgroundColor: AppColors.gainsboro,
                            disabledTextColor: AppColors.sonicSilver,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
