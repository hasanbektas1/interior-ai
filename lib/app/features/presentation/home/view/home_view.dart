import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_state.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/home_content.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/paywall_view.dart';
import 'package:interior_ai/app/features/presentation/settings/view/settings_view.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      appBar: AppBar(
        backgroundColor: AppColors.ghostWhite,
        surfaceTintColor: AppColors.ghostWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: context.width24,
        title: const Text(
          AppStrings.appName,
          style: TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          BlocBuilder<CreditsCubit, CreditsState>(
            buildWhen: (a, b) => a.balance != b.balance,
            builder: (context, state) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const PaywallView())),
              child: Container(
                height: context.height36,
                padding: EdgeInsets.symmetric(horizontal: context.width12),
                decoration: BoxDecoration(
                  color: AppColors.softPurpleFaint,
                  borderRadius: BorderRadius.circular(context.width32),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: context.width16,
                      color: AppColors.hanPurple,
                    ),
                    SizedBox(width: context.width4),
                    Text(
                      '${state.balance}',
                      style: const TextStyle(
                        color: AppColors.hanPurple,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: context.width8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const PaywallView())),
            child: Container(
              height: context.height36,
              padding: EdgeInsets.symmetric(horizontal: context.width16),
              decoration: BoxDecoration(
                color: AppColors.hanPurple,
                borderRadius: BorderRadius.circular(context.width32),
              ),
              alignment: Alignment.center,
              child: const Text(
                AppStrings.homePro,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: context.width12),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsView())),
            child: SizedBox(
              width: context.width28,
              height: context.height28,
              child: Center(
                child: SvgPicture.asset(
                  AppAsset.homeSettingsIcon.path,
                  width: context.width24,
                  height: context.height24,
                ),
              ),
            ),
          ),
          SizedBox(width: context.width20),
        ],
      ),
      body: const HomeContent(),
    );
  }
}
