import 'package:hive_flutter/hive_flutter.dart';

/// Hive-backed persistence for one-time feature intro tutorials. Each feature
/// stores a `true` flag under its key once its tutorial has been shown, so the
/// intro appears only on the first visit (until the app is reinstalled).
final class TutorialStorage {
  static const String _boxName = 'tutorial_box';

  Box get _box => Hive.box(_boxName);

  /// Opens the Hive box. Must be awaited once during app startup.
  static Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  bool hasSeen(String key) => _box.get(key, defaultValue: false) as bool;

  Future<void> markSeen(String key) => _box.put(key, true);
}
