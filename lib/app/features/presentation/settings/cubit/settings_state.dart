import 'package:equatable/equatable.dart';

final class SettingsState extends Equatable {
  final bool isPremium;
  final bool isUserIdCopied;
  final String userId;

  const SettingsState({
    this.isPremium = false,
    this.isUserIdCopied = false,
    this.userId = '',
  });

  SettingsState copyWith({
    bool? isPremium,
    bool? isUserIdCopied,
    String? userId,
  }) {
    return SettingsState(
      isPremium: isPremium ?? this.isPremium,
      isUserIdCopied: isUserIdCopied ?? this.isUserIdCopied,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [isPremium, isUserIdCopied, userId];
}
