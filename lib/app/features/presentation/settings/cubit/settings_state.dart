import 'package:equatable/equatable.dart';

final class SettingsState extends Equatable {
  final bool isPremium;

  const SettingsState({this.isPremium = false});

  SettingsState copyWith({bool? isPremium}) {
    return SettingsState(isPremium: isPremium ?? this.isPremium);
  }

  @override
  List<Object?> get props => [isPremium];
}
