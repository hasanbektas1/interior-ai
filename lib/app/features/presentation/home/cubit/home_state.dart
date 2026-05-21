import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/features/data/models/test_model.dart';

enum HomeTab { home, collection }

final class HomeState extends Equatable {
  final bool isLoading;
  final List<TestModel> testList;
  final HomeTab selectedTab;

  const HomeState({
    required this.isLoading,
    required this.testList,
    this.selectedTab = HomeTab.home,
  });

  HomeState copyWith({
    bool? isLoading,
    List<TestModel>? testList,
    HomeTab? selectedTab,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      testList: testList ?? this.testList,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object> get props => [isLoading, testList, selectedTab];
}
