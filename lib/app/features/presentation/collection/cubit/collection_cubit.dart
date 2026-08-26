import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_state.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';
import 'package:interior_ai/core/helpers/gallery_saver_service.dart';
import 'package:interior_ai/core/storage/collection_storage.dart';

final class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit({
    required CollectionStorage storage,
    required GallerySaverService gallerySaver,
  }) : _storage = storage,
       _gallerySaver = gallerySaver,
       super(const CollectionState()) {
    _load();
  }

  final CollectionStorage _storage;
  final GallerySaverService _gallerySaver;

  void _load() {
    // Drop items left "generating" by an interrupted session (the work was
    // lost when the app closed), so the UI never shows a stuck card.
    final stale = _storage.getAll().where((item) => item.isGenerating);
    for (final item in stale) {
      _storage.delete(item.id);
    }
    final items = _storage.getAll()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(state.copyWith(items: items));
  }

  void selectFilter(CollectionCategory? category) {
    if (category == null) {
      emit(state.copyWith(clearFilter: true));
      return;
    }
    emit(state.copyWith(filter: category));
  }

  Future<void> addItem(CollectionItem item) async {
    await _storage.put(item);
    emit(state.copyWith(items: [item, ...state.items]));
  }

  Future<void> deleteItem(String id) async {
    await _storage.delete(id);
    emit(
      state.copyWith(
        items: state.items.where((item) => item.id != id).toList(),
      ),
    );
  }

  /// Deletes the collection item that holds [imagePath] (used by the design
  /// flows' result screen "Delete" action, which only knows the result path).
  Future<void> deleteByImagePath(String imagePath) async {
    for (final item in state.items) {
      if (item.imagePath == imagePath) {
        await deleteItem(item.id);
        return;
      }
    }
  }

  /// Adds a placeholder item shown as "generating" and returns its id so the
  /// caller can mark it complete once the result is ready.
  Future<String> startGenerating({
    required CollectionCategory category,
    required String title,
    required String placeholderImagePath,
    required String styleLabel,
    RoomType? roomType,
    String? prompt,
  }) async {
    final now = DateTime.now();
    final item = CollectionItem(
      id: now.microsecondsSinceEpoch.toString(),
      title: _numberedTitle(title),
      category: category,
      dateLabel: _formatDate(now),
      createdAt: now.millisecondsSinceEpoch,
      imagePath: placeholderImagePath,
      isGenerating: true,
      roomType: roomType,
      styleLabel: styleLabel,
      prompt: prompt,
    );
    await addItem(item);
    return item.id;
  }

  /// Flips a generating item to its finished state with the produced image.
  Future<void> completeGenerating(String id, String imagePath) async {
    final index = state.items.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final updated = state.items[index].copyWith(
      isGenerating: false,
      imagePath: imagePath,
      dateLabel: _formatDate(DateTime.now()),
    );
    await _storage.put(updated);
    final items = [...state.items];
    items[index] = updated;
    emit(state.copyWith(items: items));
  }

  /// Appends an auto-incrementing "#n" suffix to [base] so repeated designs of
  /// the same kind read as "Interior Design #1", "Interior Design #2", …
  String _numberedTitle(String base) {
    final prefix = '$base #';
    int maxIndex = 0;
    for (final item in state.items) {
      if (item.title == base) {
        if (maxIndex < 1) maxIndex = 1;
      } else if (item.title.startsWith(prefix)) {
        final parsed = int.tryParse(item.title.substring(prefix.length));
        if (parsed != null && parsed > maxIndex) maxIndex = parsed;
      }
    }
    return '$base #${maxIndex + 1}';
  }

  Future<bool> saveToGallery(String imagePath) => _gallerySaver.save(imagePath);

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String _formatDate(DateTime date) {
    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour < 12 ? 'AM' : 'PM';
    return '${date.day} ${_months[date.month - 1]} ${date.year}, '
        '$hour12:$minute $period';
  }
}
