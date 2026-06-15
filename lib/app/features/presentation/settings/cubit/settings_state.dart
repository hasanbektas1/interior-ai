import 'package:equatable/equatable.dart';

final class SettingsState extends Equatable {
  final bool isPremium;
  final bool isUserIdCopied;

  const SettingsState({this.isPremium = false, this.isUserIdCopied = false});

  SettingsState copyWith({bool? isPremium, bool? isUserIdCopied}) {
    return SettingsState(
      isPremium: isPremium ?? this.isPremium,
      isUserIdCopied: isUserIdCopied ?? this.isUserIdCopied,
    );
  }

  @override
  List<Object?> get props => [isPremium, isUserIdCopied];
}
