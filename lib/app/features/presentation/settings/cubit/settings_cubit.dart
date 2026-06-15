import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/settings/cubit/settings_state.dart';

final class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setPremium(bool isPremium) {
    emit(state.copyWith(isPremium: isPremium));
  }

  void togglePremium() {
    emit(state.copyWith(isPremium: !state.isPremium));
  }

  Future<void> markUserIdCopied() async {
    emit(state.copyWith(isUserIdCopied: true));
    await Future.delayed(const Duration(seconds: 2));
    if (!isClosed) emit(state.copyWith(isUserIdCopied: false));
  }
}
