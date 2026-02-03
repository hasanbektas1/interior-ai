import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/features/presentation/test/cubit/test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:interior_ai/app/features/presentation/test/cubit/test_state.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TestCubit, TestState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
              ),
            );
          }
          if (state.testList.isEmpty) {
            return const Center(
              child: Text("No Data", style: TextStyle(color: AppColors.azure)),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final test = state.testList[index];
              return ListTile(
                title: Text(test.title ?? ""),
                subtitle: Text("${test.count ?? ""}"),
                selected: test.hasTest ?? false,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemCount: state.testList.length,
          );
        },
      ),
    );
  }
}
