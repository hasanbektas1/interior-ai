import 'package:hive_flutter/hive_flutter.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';

/// Hive-backed persistence for the user's collection of generated designs.
/// Each item is stored as a `Map` keyed by its id.
final class CollectionStorage {
  static const String _boxName = 'collection_box';

  Box get _box => Hive.box(_boxName);

  /// Opens the Hive box. Must be awaited once during app startup.
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  List<CollectionItem> getAll() {
    final items = <CollectionItem>[];
    for (final value in _box.values) {
      try {
        items.add(CollectionItem.fromMap(Map<dynamic, dynamic>.from(value)));
      } catch (_) {
        // Skip a corrupt/legacy record instead of failing the whole load.
      }
    }
    return items;
  }

  Future<void> put(CollectionItem item) => _box.put(item.id, item.toMap());

  Future<void> delete(String id) => _box.delete(id);
}
