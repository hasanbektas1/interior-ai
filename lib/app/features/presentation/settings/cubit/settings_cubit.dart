import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/settings/cubit/settings_state.dart';
import 'package:interior_ai/core/helpers/purchase_service.dart';

final class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _loadUserId();
  }

  /// The RevenueCat app user id, shown in Settings for support purposes.
  Future<void> _loadUserId() async {
    try {
      final id = await PurchaseService.appUserId();
      if (!isClosed) emit(state.copyWith(userId: id));
    } catch (_) {}
  }

  Future<void> markUserIdCopied() async {
    emit(state.copyWith(isUserIdCopied: true));
    await Future.delayed(const Duration(seconds: 2));
    if (!isClosed) emit(state.copyWith(isUserIdCopied: false));
  }
}
