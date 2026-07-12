import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/rate_us_dialog.dart';
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
            child: Stack(
              children: [
                Column(
                  children: [
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
                              3 => DreamSpaceView(
                                mainImage: state.dreamMainImage,
                                miniImage: state.dreamMiniImage,
                              ),
                              4 => const HelpUsGrowView(),
                              _ => const WelcomeView(),
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        24,
                        12,
                        24,
                        state.step == OnboardingStep.helpUsGrow ? 12 : 40,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OnboardingPageIndicator(
                            currentIndex: state.pageIndex,
                            count: 5,
                          ),
                          const SizedBox(height: 16),
                          AppButton.fill(
                            text: state.buttonText,
                            onPressed: state.isButtonEnabled
                                ? () async {
                                    if (state.step ==
                                        OnboardingStep.helpUsGrow) {
                                      await RateUsDialog.show(context, (rating) {
                                        Navigator.of(context).maybePop();
                                      });
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
                          if (state.step == OnboardingStep.helpUsGrow) ...[
                            const SizedBox(height: 2),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const MainView(),
                                  ),
                                  (_) => false,
                                );
                              },
                              behavior: HitTestBehavior.opaque,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  'Maybe Later',
                                  style: TextStyle(
                                    color: AppColors.richBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (state.step == OnboardingStep.processing)
                  const ProcessingView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
