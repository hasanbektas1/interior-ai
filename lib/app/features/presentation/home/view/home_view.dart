import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_home_assets.dart';
import 'package:interior_ai/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:interior_ai/app/features/presentation/home/cubit/home_state.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/app_bottom_nav_bar.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/collection_placeholder.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/home_content.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
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
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Container(
                  width: context.width40,
                  height: context.height36,
                  decoration: BoxDecoration(
                    color: AppColors.hanPurple,
                    borderRadius: BorderRadius.circular(context.width10),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppHomeIcon.premium.path,
                    width: context.width20,
                    height: context.height20,
                  ),
                ),
              ),
              SizedBox(width: context.width12),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: SizedBox(
                  width: context.width28,
                  height: context.height28,
                  child: Center(
                    child: SvgPicture.asset(
                      AppHomeIcon.settings.path,
                      width: context.width24,
                      height: context.height24,
                    ),
                  ),
                ),
              ),
              SizedBox(width: context.width20),
            ],
          ),
          body: state.selectedTab == HomeTab.home
              ? const HomeContent()
              : const CollectionPlaceholder(),
          bottomNavigationBar: AppBottomNavBar(
            selectedTab: state.selectedTab,
            onTabSelected: cubit.selectTab,
          ),
        );
      },
    );
  }
}
