import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/main/cubit/main_state.dart';

final class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void changeTab(int index) {
    if (state.currentIndex == index) return;
    emit(state.copyWith(currentIndex: index));
  }
}
