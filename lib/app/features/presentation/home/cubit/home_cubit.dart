import 'package:interior_ai/app/features/data/repositories/test_repository.dart';
import 'package:interior_ai/app/features/presentation/home/cubit/home_state.dart';
import 'package:interior_ai/core/widgets/snackbar/app_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

final class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required TestRepository testRepository})
    : _testRepository = testRepository,
      super(const HomeState(isLoading: false, testList: []));

  final TestRepository _testRepository;

  void selectTab(HomeTab tab) {
    if (state.selectedTab == tab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  Future<void> getAllTests() async {
    emit(state.copyWith(isLoading: true, testList: []));
    await Future.delayed(Durations.extralong4 * 4);
    var dataResult = await _testRepository.getAll();
    if (!dataResult.success) {
      AppSnackBar.show(dataResult.message ?? "Unknown error");
      emit(state.copyWith(isLoading: false));
      return;
    }
    emit(state.copyWith(isLoading: false, testList: dataResult.data));
  }
}
