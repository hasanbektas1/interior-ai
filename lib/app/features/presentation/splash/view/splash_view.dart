import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/get_it/get_it.dart';
import 'package:interior_ai/app/features/presentation/main/view/main_view.dart';
import 'package:interior_ai/app/features/presentation/onboarding/view/onboarding_view.dart';
import 'package:interior_ai/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:interior_ai/core/storage/tutorial_storage.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      final seenOnboarding =
          getIt<TutorialStorage>().hasSeen(TutorialStorage.onboardingKey);
      Navigation.pushAndRemoveAll(
        page: seenOnboarding ? const MainView() : const OnboardingView(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.appName,
              style: TextStyle(
                color: AppColors.hanPurple,
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
