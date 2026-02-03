import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/features/data/models/test_model.dart';

final class OnboardingState extends Equatable {
  final bool isLoading;
  final List<TestModel> testList;

  const OnboardingState({required this.isLoading, required this.testList});

  OnboardingState copyWith({bool? isLoading, List<TestModel>? testList}) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      testList: testList ?? this.testList,
    );
  }

  @override
  List<Object> get props => [isLoading, testList];
}
