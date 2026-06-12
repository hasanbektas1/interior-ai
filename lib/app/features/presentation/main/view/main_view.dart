import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/features/presentation/collection/view/collection_view.dart';
import 'package:interior_ai/app/features/presentation/home/view/home_view.dart';
import 'package:interior_ai/app/features/presentation/main/cubit/main_cubit.dart';
import 'package:interior_ai/app/features/presentation/main/cubit/main_state.dart';
import 'package:interior_ai/app/features/presentation/main/widgets/app_bottom_nav_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  static const List<Widget> _pages = <Widget>[HomeView(), CollectionView()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        return Scaffold(
          backgroundColor: AppColors.ghostWhite,
          body: IndexedStack(index: state.currentIndex, children: _pages),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: state.currentIndex,
            onTabSelected: cubit.changeTab,
          ),
        );
      },
    );
  }
}
