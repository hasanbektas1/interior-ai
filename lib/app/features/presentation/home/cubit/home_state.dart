import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/features/data/models/test_model.dart';

final class HomeState extends Equatable {
  final bool isLoading;
  final List<TestModel> testList;

  const HomeState({required this.isLoading, required this.testList});

  HomeState copyWith({bool? isLoading, List<TestModel>? testList}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      testList: testList ?? this.testList,
    );
  }

  @override
  List<Object> get props => [isLoading, testList];
}
