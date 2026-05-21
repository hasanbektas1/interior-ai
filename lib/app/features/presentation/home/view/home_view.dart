import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_home_assets.dart';
import 'package:interior_ai/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:interior_ai/app/features/presentation/home/cubit/home_state.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/app_bottom_nav_bar.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/home_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          backgroundColor: AppColors.ghostWhite,
          appBar: _HomeAppBar(),
          body: state.selectedTab == HomeTab.home
              ? const _HomeContent()
              : const _CollectionPlaceholder(),
          bottomNavigationBar: AppBottomNavBar(
            selectedTab: state.selectedTab,
            onTabSelected: cubit.selectTab,
          ),
        );
      },
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.ghostWhite,
      surfaceTintColor: AppColors.ghostWhite,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 24,
      title: const Text(
        AppStrings.appName,
        style: TextStyle(
          color: AppColors.smokyBlack,
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        _PremiumButton(onTap: () {}),
        const SizedBox(width: 12),
        _SettingsButton(onTap: () {}),
        const SizedBox(width: 20),
      ],
    );
  }
}

class _PremiumButton extends StatelessWidget {
  const _PremiumButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 40,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.hanPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AppHomeIcon.premium.path,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 28,
        child: Center(
          child: SvgPicture.asset(
            AppHomeIcon.settings.path,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 20.0;
    const gap = 12.0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        horizontalPadding,
        8,
        horizontalPadding,
        24,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tileWidth = (constraints.maxWidth - gap) / 2;
          final tileHeight = tileWidth;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 230,
                child: HomeCard(
                  image: AppHomeImage.interiorDesign,
                  onTap: () {},
                ),
              ),
              const SizedBox(height: gap),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: tileWidth,
                    height: tileHeight,
                    child: HomeCard(
                      image: AppHomeImage.exteriorDesign,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: gap),
                  SizedBox(
                    width: tileWidth,
                    height: tileHeight,
                    child: HomeCard(
                      image: AppHomeImage.replaceObjects,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: gap),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: Column(
                      children: [
                        SizedBox(
                          height: tileHeight,
                          child: HomeCard(
                            image: AppHomeImage.floorRestyle,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(height: gap),
                        SizedBox(
                          height: tileHeight,
                          child: HomeCard(
                            image: AppHomeImage.gardenDesign,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: gap),
                  SizedBox(
                    width: tileWidth,
                    height: tileHeight * 2 + gap,
                    child: HomeCard(
                      image: AppHomeImage.styleReference,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CollectionPlaceholder extends StatelessWidget {
  const _CollectionPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        AppStrings.navCollection,
        style: TextStyle(
          color: AppColors.nickel,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
